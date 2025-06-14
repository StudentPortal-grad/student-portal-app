import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'global_search_event.dart';

part 'global_search_state.dart';

class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  GlobalSearchBloc() : super(GlobalSearchInitial()) {
    on<SearchEvent>(_searchEvent);
  }

  Future<void> _searchEvent(SearchEvent event, Emitter<GlobalSearchState> emit) async {
    if (!event.noLoading) emit(GlobalSearchLoading());
  }
}
