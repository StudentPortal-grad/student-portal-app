import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/message.dart';
import '../repo/messaging_repo.dart';

class GetConversationUc {
  final MessagingRepo messagingRepo;

  GetConversationUc({required this.messagingRepo});

  Future<Either<Failure, List<Message>>> call() async => await messagingRepo.getConversations();
}
