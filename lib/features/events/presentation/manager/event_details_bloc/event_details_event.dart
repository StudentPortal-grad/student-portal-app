part of 'event_details_bloc.dart';

@immutable
sealed class EventDetailsEvent {}

class EventsRequested extends EventDetailsEvent {
  final String eventId;
  final bool noLoading;

  EventsRequested({required this.eventId, this.noLoading = false});
}
