part of 'resource_details_bloc.dart';

@immutable
sealed class ResourceDetailsEvent {}

class GetResourceEvent extends ResourceDetailsEvent {
  final String resourceId;

  GetResourceEvent({required this.resourceId});
}

class CommentResourceEvent extends ResourceDetailsEvent {
  final ReplyDto replyDto;

  CommentResourceEvent({required this.replyDto});
}
