part of 'global_search_bloc.dart';

@immutable
sealed class GlobalSearchEvent {}

class SearchEvent extends GlobalSearchEvent {
  final String? query;
  final bool noLoading;

  SearchEvent({this.query, this.noLoading = false});
}
