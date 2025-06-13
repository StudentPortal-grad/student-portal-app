import '../repo/messaging_repo.dart';

class SendMessageUc {
  final MessagingRepo messagingRepo;

  SendMessageUc({required this.messagingRepo});
  void call(Map<String, dynamic> messagePayload) {
    messagingRepo.sendMessage(messagePayload);
  }
}
