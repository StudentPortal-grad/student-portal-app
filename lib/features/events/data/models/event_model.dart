class Event {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? eventImage;
  final String? visibility;
  final List<dynamic>? attendees;
  final Creator? creatorId;
  final String? status;
  final List<dynamic>? recommendations;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Rsvp>? rsvps;
  final int? v;

  Event({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
    this.eventImage,
    this.visibility,
    this.attendees,
    this.creatorId,
    this.status,
    this.recommendations,
    this.createdAt,
    this.updatedAt,
    this.rsvps,
    this.v,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['_id'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    startDate: json['startDate'] != null ? DateTime.tryParse(json['startDate']) : null,
    endDate: json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
    location: json['location'] as String?,
    eventImage: json['eventImage'] as String?,
    visibility: json['visibility'] as String?,
    attendees: json['attendees'] as List<dynamic>?,
    creatorId: json['creatorId'] != null ? Creator.fromJson(json['creatorId']) : null,
    status: json['status'] as String?,
    recommendations: json['recommendations'] as List<dynamic>?,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    rsvps: (json['rsvps'] as List<dynamic>?)
        ?.map((r) => Rsvp.fromJson(r))
        .toList(),
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'description': description,
    'startDate': startDate?.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'location': location,
    'eventImage': eventImage,
    'visibility': visibility,
    'attendees': attendees,
    'creatorId': creatorId?.toJson(),
    'status': status,
    'recommendations': recommendations,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'rsvps': rsvps?.map((r) => r.toJson()).toList(),
    '__v': v,
  };
}

class Creator {
  final String? id;
  final String? name;
  final String? profilePicture;

  Creator({
    this.id,
    this.name,
    this.profilePicture,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    profilePicture: json['profilePicture'] as String?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'profilePicture': profilePicture,
  };
}

class Rsvp {
  final RsvpUser? rsvpUser;
  final String? status;
  final DateTime? updatedAt;
  final String? id;

  Rsvp({
    this.rsvpUser,
    this.status,
    this.updatedAt,
    this.id,
  });

  factory Rsvp.fromJson(Map<String, dynamic> json) => Rsvp(
    rsvpUser: RsvpUser.fromJson(json['userId']),
    status: json['status'] as String?,
    updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    id: json['_id'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'userId': rsvpUser,
    'status': status,
    'updatedAt': updatedAt?.toIso8601String(),
    '_id': id,
  };
}

class RsvpUser {
  final String? id;
  final String? name;
  final String? profilePicture;

  RsvpUser(
      {required this.id, required this.name, required this.profilePicture});

  factory RsvpUser.fromJson(Map<String, dynamic> json) => RsvpUser(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        profilePicture: json['profilePicture'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'profilePicture': profilePicture,
      };
}
