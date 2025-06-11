part of 'resource_details_bloc.dart';

@immutable
sealed class ResourceDetailsState {}

final class ResourceDetailsInitial extends ResourceDetailsState {}

final class ResourceDetailsLoadingState extends ResourceDetailsState {}

final class ResourceDetailsLoadedState extends ResourceDetailsState {
  final Resource discussion;

  ResourceDetailsLoadedState(this.discussion);
}

final class ResourceDetailsErrorState extends ResourceDetailsState {
  final String message;

  ResourceDetailsErrorState(this.message);
}

final class AddCommentLoadingState extends ResourceDetailsState {}

final class AddCommentSuccessState extends ResourceDetailsState {
  final String message;

  AddCommentSuccessState(this.message);
}

final class AddCommentErrorState extends ResourceDetailsState {
  final String message;

  AddCommentErrorState(this.message);
}

final class VoteSuccessState extends ResourceDetailsState {}

final class VoteErrorState extends ResourceDetailsState {
  final String message;

  VoteErrorState(this.message);
}
