import '../repo/messaging_repo.dart';

class CreateChatUc {
  final MessagingRepo messagingRepo;

  CreateChatUc(this.messagingRepo);

  void call(Map<String, dynamic> messagePayload) {
    messagingRepo.sendMessage(messagePayload, isConversionExisted: true);
  }
}
