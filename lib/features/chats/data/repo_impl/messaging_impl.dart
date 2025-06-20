import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/features/chats/data/model/conversation_messages.dart';

import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/socket_service.dart';
import '../../domain/repo/messaging_repo.dart';
import '../dto/attachment_dto.dart';
import '../model/conversation.dart';
import '../model/message.dart';

class MessagingImpl implements MessagingRepo {
  final ApiService apiService;

  MessagingImpl(this.apiService);

  final StreamController<List<Conversation>> _liveMessagesController = StreamController.broadcast();

  final StreamController<Message> _newMessageController = StreamController.broadcast();


  @override
  void getConversations() {
    log('Getting conversations');
    SocketService.emit(SocketEvents.getConversations);
    SocketService.listen(SocketEvents.conversations, (data) {
      try {
        log('conversations :: ${data['conversations'].toString()}');
        final List<Conversation> conversation = (data['conversations'] as List)
            .map((e) => Conversation.fromJson(e as Map<String, dynamic>))
            .toList();
        _liveMessagesController.add(conversation);
      } catch (e, stack) {
        log('Failed to parse socket message: $e\n$stack');
      }
    });
  }

  @override
  Stream<List<Conversation>> getLiveMessages() => _liveMessagesController.stream;

  @override
  void disposeSocketListener() {
    SocketService.socket.off(SocketEvents.getConversations);
    SocketService.socket.off(SocketEvents.newMessage);
    _liveMessagesController.close();
    _newMessageController.close();
  }

  @override
  Future<Either<Failure, ConversationMessages>> getConversationMessages({required String id}) async {
    try {
      var data = await apiService.get(
        endpoint: ApiEndpoints.conversationID(id),
      );
      log("MESSAGES:: $data");
      return Right(ConversationMessages.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
  @override
  Future<Either<Failure, Message>> sendAttachment(AttachmentDto attachmentDto) async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.messages(attachmentDto.conversationId),
        formData: await attachmentDto.toFormData(),
      );
      log("Attachment MESSAGES:: $data");
      return Right(Message.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
  @override
  void sendMessage(Map<String, dynamic> messagePayload,) {
    log("Sending message: $messagePayload");
    SocketService.emit(SocketEvents.sendMessage, message: messagePayload);
  }

  @override
  void listenToIncomingMessages() {

    SocketService.listen(SocketEvents.messageSent, (data) {
      try {
        log("My message Sent :: $data");
        final message = Message.fromJson(data as Map<String, dynamic>);
        _newMessageController.add(message);
      } catch (e, stack) {
        log('Failed to parse messageSent: $e\n$stack');
      }
    });

    SocketService.listen(SocketEvents.newMessage, (data) {
      try {
        log("New message :: $data");
        final messageData = data['message'] as Map<String, dynamic> ;
        final message = Message.fromJson(messageData);
        _newMessageController.add(message);
      } catch (e, stack) {
        log('Failed to parse newMessage: $e\n$stack');
      }
    });
  }

  @override
  Stream<Message> get incomingMessages => _newMessageController.stream;
}
