class UserRole {
  final String communityId;
  final String role;

  UserRole({required this.communityId, required this.role});

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      communityId: json['communityId'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'communityId': communityId,
      'role': role,
    };
  }
}
