import '../../../auth/data/model/user_model/user.dart';

class Participant {
  final User? userId;
  final String? role;
  final bool? isAdmin;
  final DateTime? joinedAt;
  final DateTime? lastSeen;

  Participant({
    required this.userId,
    this.role,
    this.isAdmin,
    this.joinedAt,
    this.lastSeen,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: User.fromJson(json['userId']),
      role: json['role'],
      isAdmin: json['isAdmin'],
      joinedAt: json['joinedAt'] != null ? DateTime.parse(json['joinedAt']) : null,
      lastSeen: json['lastSeen'] != null ? DateTime.parse(json['lastSeen']) : null,
    );
  }
}
