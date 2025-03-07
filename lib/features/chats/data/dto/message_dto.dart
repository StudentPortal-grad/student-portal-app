import 'attachment_dto.dart';

class MessageDto {
  final String id;
  final String senderId;
  final String? content;
  final List<AttachmentDto>? attachments;
  final String status;
  final DateTime createdAt;
  final MessageDto? reply;

  MessageDto({
    required this.id,
    required this.senderId,
    this.content,
    this.attachments,
    this.status = "sent",
    required this.createdAt,
    this.reply,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) {
    return MessageDto(
      id: json['_id'] as String,
      senderId: json['senderId'] as String,
      content: json['content'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String? ?? "sent",
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      reply: json['reply'] != null ? MessageDto.fromJson(json['reply']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'senderId': senderId,
      'content': content,
      'attachments': attachments?.map((e) => e.toJson()).toList(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'reply': reply?.toJson(),
    };
  }
}
