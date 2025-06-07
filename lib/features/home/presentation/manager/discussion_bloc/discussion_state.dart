part of 'discussion_bloc.dart';

@immutable
sealed class DiscussionState {}

final class DiscussionInitial extends DiscussionState {}

class DiscussionLoading extends DiscussionState {}

class DiscussionLoaded extends DiscussionState {
  final List<Discussion> posts;
  final bool hasMore;

  DiscussionLoaded(this.posts, {this.hasMore = true});
}

class DiscussionFailed extends DiscussionState {
  final String message;

  DiscussionFailed(this.message);
}
