part of 'chats_bloc.dart';

@immutable
sealed class ChatsState {}

final class ChatsInitial extends ChatsState {}

final class ChatsStreamUpdated extends ChatsState {
  final List<Conversation> conversations;

  ChatsStreamUpdated(this.conversations);
}
