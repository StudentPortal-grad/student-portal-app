import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/groups/data/models/user_sibling.dart';
import 'package:student_portal/features/groups/domain/repo/group_repository.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../domain/usecases/search_users_siblings_uc.dart';

part 'search_people_event.dart';
part 'search_people_state.dart';

class SearchPeopleBloc extends Bloc<SearchPeopleEvent, SearchPeopleState> {
  SearchPeopleBloc() : super(SearchPeopleInitial()) {
    on<SearchPeopleEventStarted>(_searchPeopleEventStarted);
  }

  final SearchUsersSiblingsUc searchUsersSiblingsUc = SearchUsersSiblingsUc(getIt<GroupRepository>());

  Future<void> _searchPeopleEventStarted(
      SearchPeopleEventStarted event, Emitter<SearchPeopleState> emit) async {
    if (!event.noLoading) emit(SearchPeopleLoading());
    final result = await searchUsersSiblingsUc.call(
      query: event.query,
    );
    result.fold(
      (error) => emit(SearchPeopleFailed(error.message ?? 'Something went wrong')),
      (users) => emit(SearchPeopleLoaded(users)),
    );
  }
}
