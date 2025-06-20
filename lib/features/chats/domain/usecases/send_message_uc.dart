import 'package:dartz/dartz.dart';
import 'package:student_portal/features/chats/data/dto/attachment_dto.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/message.dart';
import '../repo/messaging_repo.dart';

class SendMessageUc {
  final MessagingRepo messagingRepo;

  SendMessageUc({required this.messagingRepo});

  void call(Map<String, dynamic> messagePayload) {
    messagingRepo.sendMessage(messagePayload);
  }

  Future<Either<Failure, Message>> sendAttachment(AttachmentDto attachmentDto) => messagingRepo.sendAttachment(attachmentDto);
}
