part of 'global_search_bloc.dart';

@immutable
sealed class GlobalSearchEvent {}

class SearchEventRequest extends GlobalSearchEvent {
  final String? query;
  final bool noLoading;

  SearchEventRequest({this.query, this.noLoading = false});
}
