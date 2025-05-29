part of 'events_bloc.dart';

@immutable
sealed class EventsEvent {}

class EventsRequested extends EventsEvent {}