part of 'discussion_bloc.dart';

@immutable
sealed class DiscussionEvent {}

class DiscussionRequested extends DiscussionEvent {
  final bool noLoading;

  DiscussionRequested({this.noLoading = false});
}

class DiscussionLoadMoreRequested extends DiscussionEvent {}

class VoteDiscussionEvent extends DiscussionEvent {
  final VoteDto voteDto;

  VoteDiscussionEvent({required this.voteDto});
}