part of 'resource_details_bloc.dart';

@immutable
sealed class ResourceDetailsState {}

final class ResourceDetailsInitial extends ResourceDetailsState {}


final class AddCommentLoadingState extends ResourceDetailsState {}
final class AddCommentSuccessState extends ResourceDetailsState {
  final String message;

  AddCommentSuccessState(this.message);
}

final class AddCommentErrorState extends ResourceDetailsState {
  final String message;

  AddCommentErrorState(this.message);
}
