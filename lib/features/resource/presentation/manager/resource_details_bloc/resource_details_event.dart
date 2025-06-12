part of 'resource_details_bloc.dart';

@immutable
sealed class ResourceDetailsEvent {}

class GetResourceEvent extends ResourceDetailsEvent {
  final String resourceId;
  final bool noLoading;

  GetResourceEvent({required this.resourceId, this.noLoading = false});
}

class CommentResourceEvent extends ResourceDetailsEvent {
  final ReplyDto replyDto;

  CommentResourceEvent({required this.replyDto});
}

class VoteDiscussionEventRequest extends ResourceDetailsEvent {
  final VoteDto voteDto;

  VoteDiscussionEventRequest({required this.voteDto});
}

class DeleteCommentResourceEvent extends ResourceDetailsEvent {
  final String replyId;
  final String resourceId;

  DeleteCommentResourceEvent({required this.replyId, required this.resourceId});
}
