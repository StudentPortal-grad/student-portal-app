part of 'events_bloc.dart';

@immutable
sealed class EventsState {}

final class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<Event> events;
  final bool hasMore;

  EventsLoaded(this.events, {this.hasMore = false});
}

class EventsError extends EventsState {
  final String message;

  EventsError(this.message);
}