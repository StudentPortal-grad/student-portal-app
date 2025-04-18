import '../../data/model/conversation.dart';

abstract class MessagingRepo {
// socket
  Stream<List<Conversation>> getLiveMessages();

  void getConversations();

  void disposeSocketListener();
}
