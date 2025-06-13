import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:student_portal/core/errors/data/model/error_model.dart';

import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/socket_service.dart';
import '../../domain/repo/messaging_repo.dart';
import '../model/conversation.dart';
import '../model/message.dart';

class MessagingImpl implements MessagingRepo {
  final ApiService apiService;

  MessagingImpl(this.apiService);

  final StreamController<List<Conversation>> _liveMessagesController =
      StreamController.broadcast();

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
    _liveMessagesController.close();
  }

  @override
  Future<Either<Failure, List<Message>>> getConversationMessages({required String id}) async {
    try {
      var data = await apiService.get(
        endpoint: ApiEndpoints.conversationID(id),
      );
      log("MESSAGES:: $data");
      return Right((data['data'] as List).map<Message>((e) => Message.fromJson(e)).toList());
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
