import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/conversation_messages.dart';
import '../repo/messaging_repo.dart';

class GetConversationUc {
  final MessagingRepo messagingRepo;

  GetConversationUc({required this.messagingRepo});

  Future<Either<Failure, ConversationMessages>> call({required String id}) => messagingRepo.getConversationMessages(id: id);
}
