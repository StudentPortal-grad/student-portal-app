import '../../data/model/message.dart';
import '../repo/messaging_repo.dart';

class ListenToNewMessageUseCase {
  final MessagingRepo repo;

  ListenToNewMessageUseCase(this.repo);

  Stream<Message> call() {
    repo.listenToIncomingMessages();
    return repo.incomingMessages;
  }
}