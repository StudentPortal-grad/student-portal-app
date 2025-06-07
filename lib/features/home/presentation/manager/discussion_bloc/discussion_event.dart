part of 'discussion_bloc.dart';

@immutable
sealed class DiscussionEvent {}

class DiscussionRequested extends DiscussionEvent {
  final int page;
  final bool noLoading;

  DiscussionRequested({this.page = 1, this.noLoading = false});
}
