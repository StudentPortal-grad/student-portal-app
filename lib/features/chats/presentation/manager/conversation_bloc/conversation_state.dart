part of 'conversation_bloc.dart';

@immutable
sealed class ConversationState {}

final class ConversationInitial extends ConversationState {}

final class ConversationLoading extends ConversationState {}

final class ConversationLoaded extends ConversationState {
  final List<Message> chats;
  final String? message;

  ConversationLoaded({required this.chats, this.message});
}

final class ConversationFailed extends ConversationState {
  final String? message;

  ConversationFailed(this.message);
}
