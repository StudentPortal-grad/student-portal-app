import '../../data/model/conversation.dart';
import '../repo/messaging_repo.dart';

class GetChatsUc {
  final MessagingRepo messagingRepo;

  GetChatsUc({required this.messagingRepo});

  Stream<List<Conversation>> call() {
    messagingRepo.getConversations();
    return messagingRepo.getLiveMessages();
  }

  void dispose() {
    messagingRepo.disposeSocketListener();
  }
}
