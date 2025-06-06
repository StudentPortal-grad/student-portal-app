import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../data/models/event_model.dart';
import '../../../domain/repositories/events_repository.dart';
import '../../../domain/usecases/get_event_details.dart';

part 'event_details_event.dart';

part 'event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  EventDetailsBloc() : super(EventDetailsInitial()) {
    on<EventsRequested>(_onEventRequested);
  }
  final GetEventDetails getEventDetails = GetEventDetails(getIt.get<EventsRepository>());

  Future<void> _onEventRequested(
      EventsRequested event, Emitter<EventDetailsState> emit) async {
    if(!event.noLoading) emit(EventDetailsLoading());

    var data = await getEventDetails.call(event.eventId);
    data.fold(
          (error) => emit(EventDetailsFailure(error.message ?? 'Unknown error')),
          (response) => emit(EventDetailsLoaded(response)),
    );
  }

}
