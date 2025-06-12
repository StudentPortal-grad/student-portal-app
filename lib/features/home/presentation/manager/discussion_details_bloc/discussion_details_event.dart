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

class DeleteCommentDiscussionEvent extends DiscussionDetailsEvent {
  final String replyId;
  final String postId;

  DeleteCommentDiscussionEvent({required this.replyId, required this.postId});
}


class VoteDiscussionEventRequest extends DiscussionDetailsEvent {
  final VoteDto voteDto;

  VoteDiscussionEventRequest({required this.voteDto});
}
