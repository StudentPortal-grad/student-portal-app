class EventRsvpDTO {
  final String eventId;
  final String status;

  EventRsvpDTO({required this.eventId, required this.status});

  Map<String, dynamic> toJson() => {
    'status': status,
  };
}
