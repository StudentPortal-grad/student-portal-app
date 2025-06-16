part of 'global_search_bloc.dart';

@immutable
sealed class GlobalSearchState {}

final class GlobalSearchInitial extends GlobalSearchState {}

final class GlobalSearchLoading extends GlobalSearchState {}

final class GlobalSearchLoaded extends GlobalSearchState {
  final GlobalSearch globalSearch;
  final String? message;

  GlobalSearchLoaded(this.globalSearch, {this.message});
}

final class GlobalSearchFailed extends GlobalSearchState {
  final String message;

  GlobalSearchFailed(this.message);
}
