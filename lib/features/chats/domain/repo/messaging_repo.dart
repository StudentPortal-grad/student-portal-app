import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';

import '../../data/model/conversation.dart';
import '../../data/model/message.dart';

abstract class MessagingRepo {
  Stream<List<Conversation>> getLiveMessages();

  void getConversations();

  void disposeSocketListener();

  Future<Either<Failure, List<Message>>> getConversationMessages({required String id});

  void sendMessage(Map<String, dynamic> messagePayload);

  void listenToIncomingMessages();

  Stream<Message> get incomingMessages;
}
