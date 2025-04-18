import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/features/chats/data/model/message.dart';

import '../../data/dto/message_dto.dart';
import '../../data/model/conversation.dart';

abstract class MessagingRepo {
// socket
  Stream<List<Conversation>> getLiveMessages();

  void getConversations();

  void disposeSocketListener();
}
