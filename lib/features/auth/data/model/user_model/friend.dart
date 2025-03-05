class Friend {
  final String userId;
  final String messageId;

  Friend({required this.userId, required this.messageId});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      userId: json['userId'],
      messageId: json['messageId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'messageId': messageId,
    };
  }
}
