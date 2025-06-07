import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../data/models/event_model.dart';
import '../../../domain/repositories/events_repository.dart';
import '../../../domain/usecases/get_all_events.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsInitial()) {
    on<EventsRequested>(_onInitialLoad);
    on<EventsLoadMoreRequested>(_onLoadMore);
  }

  final GetAllEventsUC getAllEventsUC =
  GetAllEventsUC(getIt.get<EventsRepository>());

  final List<Event> _events = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  Future<void> _onInitialLoad(
      EventsRequested event, Emitter<EventsState> emit) async {
    _currentPage = 1;
    _hasMore = true;
    _events.clear();

    emit(EventsLoading());

    final result = await getAllEventsUC.call(page: _currentPage);
    result.fold(
          (error) => emit(EventsError(error.message ?? 'Unknown error')),
          (fetchedEvents) {
        _events.addAll(fetchedEvents);
        emit(EventsLoaded(List.from(_events)));
      },
    );
  }

  Future<void> _onLoadMore(
      EventsLoadMoreRequested event, Emitter<EventsState> emit) async {
    if (_isLoadingMore || !_hasMore) return;
    emit(EventsLoaded(List.from(_events),hasMore: _hasMore));

    _isLoadingMore = true;
    _currentPage++;
    final result = await getAllEventsUC.call(page: _currentPage);
    result.fold(
          (error) {
        _currentPage--;
        emit(EventsError(error.message ?? 'Pagination failed'));
      },
          (fetchedEvents) {
        if (fetchedEvents.isEmpty) {
          _hasMore = false;
        } else {
          _events.addAll(fetchedEvents);
        }
        emit(EventsLoaded(List.from(_events), hasMore: _hasMore));
      },
    );

    _isLoadingMore = false;
  }
}
