import '../../../auth/data/model/user_model/user.dart';

class Participant {
  final User userId;
  final String role;
  final bool isAdmin;
  final DateTime joinedAt;
  final DateTime lastSeen;

  Participant({
    required this.userId,
    required this.role,
    required this.isAdmin,
    required this.joinedAt,
    required this.lastSeen,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: User.fromJson(json['userId']),
      role: json['role'],
      isAdmin: json['isAdmin'],
      joinedAt: DateTime.parse(json['joinedAt']),
      lastSeen: DateTime.parse(json['lastSeen']),
    );
  }
}