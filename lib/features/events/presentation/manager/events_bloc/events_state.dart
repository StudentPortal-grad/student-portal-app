part of 'events_bloc.dart';

@immutable
sealed class EventsState {}

final class EventsInitial extends EventsState {}

final class EventsLoading extends EventsState {}

final class EventsLoaded extends EventsState {
  final List<Event> events;

  EventsLoaded(this.events);
}

final class EventsError extends EventsState {
  final String error;

  EventsError(this.error);
}
