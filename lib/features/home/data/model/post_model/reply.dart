import '../../../../chats/data/model/attachment.dart';

class Reply {
  final String? content;
  final String? creator;
  final List<Attachment>? attachments;
  final String? id;
  final DateTime? createdAt;

  Reply({
    this.content,
    this.creator,
    this.attachments,
    this.id,
    this.createdAt,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      content: json['content'],
      creator: json['creator'],
      attachments: (json['attachments'] as List?)
          ?.map((e) => Attachment.fromJson(e))
          .toList(),
      id: json['_id'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'creator': creator,
      'attachments': attachments?.map((e) => e.toJson()).toList(),
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
