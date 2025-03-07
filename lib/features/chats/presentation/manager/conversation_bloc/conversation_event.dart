part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}

final class GetConversationEvent extends ConversationEvent {}

final class SendMessageEvent extends ConversationEvent {}
