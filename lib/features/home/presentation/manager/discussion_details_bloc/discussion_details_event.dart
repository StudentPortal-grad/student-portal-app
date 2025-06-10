part of 'discussion_details_bloc.dart';

@immutable
sealed class DiscussionDetailsEvent {}

class DiscussionDetailsEventRequest extends DiscussionDetailsEvent {
  final String postId;

  DiscussionDetailsEventRequest(this.postId);
}

class CommentDiscussionEvent extends DiscussionDetailsEvent {
  final ReplyDto replyDto;

  CommentDiscussionEvent({required this.replyDto});
}

class VoteDiscussionEventRequest extends DiscussionDetailsEvent {
  final VoteDto voteDto;

  VoteDiscussionEventRequest({required this.voteDto});
}
