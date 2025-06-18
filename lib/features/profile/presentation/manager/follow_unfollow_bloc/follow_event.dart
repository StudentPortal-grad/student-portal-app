part of 'follow_bloc.dart';

@immutable
sealed class FollowEvent {}

final class FollowUserEvent extends FollowEvent {
  final String userId;

  FollowUserEvent(this.userId);
}

final class UnFollowUserEvent extends FollowEvent {
  final String userId;

  UnFollowUserEvent(this.userId);
}
