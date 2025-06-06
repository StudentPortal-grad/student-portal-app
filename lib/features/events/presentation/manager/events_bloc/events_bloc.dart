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
    on<EventsRequested>(_onEventsRequested);
  }

  final GetAllEventsUC getAllEventsUC =
      GetAllEventsUC(getIt.get<EventsRepository>());

  Future<void> _onEventsRequested(
      EventsEvent event, Emitter<EventsState> emit) async {
    emit(EventsLoading());

    var data = await getAllEventsUC.call();
    data.fold(
      (error) => emit(EventsError(error.message ?? 'Unknown error')),
      (response) => emit(EventsLoaded(response)),
    );
  }
}
