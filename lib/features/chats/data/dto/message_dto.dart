class MessageDto {
  final String? conversationId;
  final String? content;


  MessageDto({
    this.conversationId,
    this.content
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) {
    return MessageDto(
      content: json['content'],
      conversationId: json['conversationId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'content': content,
    };
  }
}
