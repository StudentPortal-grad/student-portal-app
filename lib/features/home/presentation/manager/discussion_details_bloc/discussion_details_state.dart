part of 'discussion_details_bloc.dart';

@immutable
sealed class DiscussionDetailsState {}

final class DiscussionDetailsInitial extends DiscussionDetailsState {}

final class DiscussionDetailsLoading extends DiscussionDetailsState {}

final class DiscussionDetailsLoaded extends DiscussionDetailsState {
  final Discussion discussion;

  DiscussionDetailsLoaded(this.discussion);
}

final class DiscussionDetailsError extends DiscussionDetailsState {
  final String message;

  DiscussionDetailsError(this.message);
}

final class AddCommentLoadingState extends DiscussionDetailsState {}

final class AddCommentErrorState extends DiscussionDetailsState {
  final String message;

  AddCommentErrorState(this.message);
}

final class VoteErrorState extends DiscussionDetailsState {
  final String message;

  VoteErrorState(this.message);
}
