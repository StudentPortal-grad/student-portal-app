class Friend {
  final String? userId;
  final String? messageId;

  Friend({required this.userId, required this.messageId});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      userId: json['userId'] as String?,
      messageId: json['messageId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'messageId': messageId,
    };
  }
}
