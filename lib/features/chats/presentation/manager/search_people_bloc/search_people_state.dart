part of 'search_people_bloc.dart';

@immutable
sealed class SearchPeopleState {}

final class SearchPeopleInitial extends SearchPeopleState {}


final class SearchPeopleLoading extends SearchPeopleState {}

final class SearchPeopleLoaded extends SearchPeopleState {
  final List<UserSibling> userSiblings;
  final String? message;

  SearchPeopleLoaded(this.userSiblings, {this.message});
}

final class SearchPeopleFailed extends SearchPeopleState {
  final String message;

  SearchPeopleFailed(this.message);
}
