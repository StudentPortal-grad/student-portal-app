part of 'follow_bloc.dart';

@immutable
sealed class FollowState {}

final class FollowInitial extends FollowState {}

final class FollowLoading extends FollowState {}

final class FollowSuccess extends FollowState {
  final String message;

  FollowSuccess(this.message);
}

final class FollowFailed extends FollowState {
  final String message;

  FollowFailed(this.message);
}

final class UnFollowLoading extends FollowState {}

final class UnFollowSuccess extends FollowState {
  final String message;

  UnFollowSuccess(this.message);
}

final class UnFollowFailed extends FollowState {
  final String message;

  UnFollowFailed(this.message);
}
