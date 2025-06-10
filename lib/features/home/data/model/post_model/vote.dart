class Vote {
  final String? userId;
  final String? voteType;
  final DateTime? createdAt;

  Vote({required this.userId, required this.voteType, required this.createdAt});

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      userId: json['userId'],
      voteType: json['voteType'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'voteType': voteType,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
