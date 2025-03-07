import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model/error_model.dart';
import 'package:student_portal/features/chats/data/model/message.dart';

import '../../data/dto/message_dto.dart';

abstract class MessagingRepo {
  Future<Either<Failure, List<Message>>> getConversations();

  Future<Either<Failure, Message>> sendMessage(MessageDto messageDto);
}
