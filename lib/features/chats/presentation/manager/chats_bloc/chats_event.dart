part of 'chats_bloc.dart';

@immutable
sealed class ChatsEvent {}

class StartListeningToConversations extends ChatsEvent {}

class NewConversationReceived extends ChatsEvent {
  final List<Conversation> conversation;

  NewConversationReceived(this.conversation);
}

class SocketErrorOccurred extends ChatsEvent {
  final String message;
  SocketErrorOccurred(this.message);
}
