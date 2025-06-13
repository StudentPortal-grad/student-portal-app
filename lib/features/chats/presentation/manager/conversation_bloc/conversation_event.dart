part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}

final class GetConversationEvent extends ConversationEvent {
  final String conversationId;

  GetConversationEvent({required this.conversationId});
}

final class SendMessageEvent extends ConversationEvent {}
