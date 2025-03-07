import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/dto/message_dto.dart';
import '../../data/model/message.dart';
import '../repo/messaging_repo.dart';

class SendMessageUc {
  final MessagingRepo messagingRepo;

  SendMessageUc({required this.messagingRepo});

  Future<Either<Failure, Message>> call(MessageDto messageDto) async => await messagingRepo.sendMessage(messageDto);
}
