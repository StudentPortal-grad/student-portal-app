part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}

final class GetConversationEvent extends ConversationEvent {
  final String conversationId;

  GetConversationEvent({required this.conversationId});
}

final class SendMessageEvent extends ConversationEvent {
  final MessageDto messageDto;

  SendMessageEvent(this.messageDto);
}

final class NewMessageReceivedEvent extends ConversationEvent {
  final Message message;

  NewMessageReceivedEvent(this.message);
}
