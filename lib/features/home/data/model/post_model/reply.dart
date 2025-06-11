import 'attachment.dart';
import 'creator.dart';

class Reply {
  final String? content;
  final Creator? creator;
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
      creator: json['creator'] != null && json['creator'] is Map<String, dynamic> ? Creator.fromJson(json['creator']) : null,
      attachments: (json['attachments'] as List?)
          ?.map((e) => Attachment.fromJson(e))
          .toList(),
      id: json['_id'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  factory Reply.fromResourceJson(Map<String, dynamic> json) {
    return Reply(
      content: json['content'],
      creator: json['userId'] != null && json['userId'] is Map<String, dynamic> ? Creator.fromJson(json['userId']) : null,
      attachments: (json['attachments'] as List?)
          ?.map((e) => Attachment.fromJson(e))
          .toList(),
      id: json['_id'],
      createdAt:
      json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'creator': creator?.toJson(),
      'attachments': attachments?.map((e) => e.toJson()).toList(),
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
