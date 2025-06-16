import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/search/domain/repo/search_repository.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../data/model/global_search.dart';
import '../../../domain/usecases/global_search_uc.dart';

part 'global_search_event.dart';

part 'global_search_state.dart';

class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  GlobalSearchBloc() : super(GlobalSearchInitial()) {
    on<SearchEventRequest>(_searchEvent);
  }

  Future<void> _searchEvent(SearchEventRequest event, Emitter<GlobalSearchState> emit) async {
    if (!event.noLoading) emit(GlobalSearchLoading());
    final result = await searchUc.call(query: event.query);
    result.fold(
      (error) => emit(GlobalSearchFailed(error.message ?? "Unknown Error")),
      (response) => emit(GlobalSearchLoaded(response)),
    );
  }

  final GlobalSearchUc searchUc = GlobalSearchUc(getIt.get<SearchRepository>());
}
