part of 'search_people_bloc.dart';

@immutable
sealed class SearchPeopleEvent {}

class SearchPeopleEventStarted extends SearchPeopleEvent {
  final String? query;
  final bool noLoading;

  SearchPeopleEventStarted({this.query, this.noLoading = false});
}