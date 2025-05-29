enum EventState { notAttending, attending, interested }

extension EventStateExtension on EventState {
  String get value {
    switch (this) {
      case EventState.notAttending:
        return 'not_attending';
      case EventState.attending:
        return 'attending';
      case EventState.interested:
        return 'interested';
    }
  }

  EventState parse(String value) {
    switch (value) {
      case 'not_attending':
        return EventState.notAttending;
      case 'attending':
        return EventState.attending;
      case 'interested':
        return EventState.interested;
      default:
        return EventState.notAttending;
    }
  }
}
