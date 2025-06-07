part of 'chats_bloc.dart';

@immutable
sealed class ChatsState {}

final class ChatsInitial extends ChatsState {}

final class ChatsStreamUpdated extends ChatsState {
  final List<Conversation> conversations;

  ChatsStreamUpdated(this.conversations);
}

final class ChatsLoading extends ChatsState {}

final class ChatsError extends ChatsState {
  final String message;

  ChatsError(this.message);
}
