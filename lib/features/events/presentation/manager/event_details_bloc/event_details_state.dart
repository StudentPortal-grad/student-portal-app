part of 'event_details_bloc.dart';

@immutable
sealed class EventDetailsState {}

final class EventDetailsInitial extends EventDetailsState {}

final class EventDetailsLoading extends EventDetailsState {}

final class EventDetailsLoaded extends EventDetailsState {
  final Event event;

  EventDetailsLoaded(this.event);
}

final class EventDetailsFailure extends EventDetailsState {
  final String failureMessage;

  EventDetailsFailure(this.failureMessage);
}
