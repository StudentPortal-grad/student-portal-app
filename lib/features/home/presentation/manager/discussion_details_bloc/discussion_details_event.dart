part of 'discussion_details_bloc.dart';

@immutable
sealed class DiscussionDetailsEvent {}

class DiscussionDetailsEventRequest extends DiscussionDetailsEvent {
  final String postId;
  final bool noLoading;

  DiscussionDetailsEventRequest({required this.postId, this.noLoading = false});
}

class CommentDiscussionEvent extends DiscussionDetailsEvent {
  final ReplyDto replyDto;

  CommentDiscussionEvent({required this.replyDto});
}

class VoteDiscussionEventRequest extends DiscussionDetailsEvent {
  final VoteDto voteDto;

  VoteDiscussionEventRequest({required this.voteDto});
}
