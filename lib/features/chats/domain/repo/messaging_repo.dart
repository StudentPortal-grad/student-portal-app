import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';

import '../../data/model/conversation.dart';
import '../../data/model/message.dart';

abstract class MessagingRepo {
  // restApi
  Future<Either<Failure, List<Message>>> getConversationMessages({required String id});

  // socket
  Stream<List<Conversation>> getLiveMessages();

  void getConversations();

  void disposeSocketListener();
}
