part of 'discussion_bloc.dart';

@immutable
sealed class DiscussionState {}

final class DiscussionInitial extends DiscussionState {}

final class DiscussionLoading extends DiscussionState {}

final class DiscussionLoaded extends DiscussionState {
  final List<Discussion> discussions;

  DiscussionLoaded(this.discussions);
}

final class DiscussionFailed extends DiscussionState {
  final String message;

  DiscussionFailed(this.message);
}
