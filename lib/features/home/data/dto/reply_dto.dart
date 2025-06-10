class ReplyDto {
  final String id;
  final String content;

  ReplyDto({required this.id, required this.content});

  Map<String, dynamic> toJson() {
    return {
      'content': content,
    };
  }

  static ReplyDto fromJson(Map<String, dynamic> json) {
    return ReplyDto(
      id: json['id'],
      content: json['content'],
    );
  }
}
