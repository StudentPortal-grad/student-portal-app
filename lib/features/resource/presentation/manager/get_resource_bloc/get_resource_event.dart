part of 'get_resource_bloc.dart';

@immutable
sealed class GetResourceEvent {}

class GetResourceEventRequested extends GetResourceEvent {
  final bool noLoading;

  GetResourceEventRequested({this.noLoading = false});
}

class GetResourceEventLoadMore extends GetResourceEvent {}

class VoteResourceEvent extends GetResourceEvent {
  final VoteDto voteDto;

  VoteResourceEvent({required this.voteDto});
}

class UpdateResourceInListEvent extends GetResourceEvent {
  final Resource updatedResource;

  UpdateResourceInListEvent(this.updatedResource);
}

class DeleteResourceEvent extends GetResourceEvent {
  final String resourceId;

  DeleteResourceEvent({required this.resourceId});
}
