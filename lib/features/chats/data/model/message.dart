import 'package:intl/intl.dart';

import 'attachment.dart';

class Message {
  Message({
    this.id,
    required this.senderId,
    this.content,
    this.attachments,
    this.status = "sent",
    DateTime? createdAt,
    this.reply,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'] as String?,
      senderId: json['senderId'] as String,
      content: json['content'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String? ?? "sent",
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      reply: json['reply'] != null ? Message.fromJson(json['reply']) : null,
    );
  }

  String? id;
  String senderId;
  String? content;
  List<Attachment>? attachments;
  String status;
  DateTime createdAt;
  Message? reply;

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

  String formattedTime() {
    return DateFormat.jm().format(createdAt.toLocal());
  }

  static List<Message> dummyData() {
    return [
      Message(
        id: '1',
        senderId: '1',
        content: 'Hii',
        attachments: [],
        createdAt: DateTime.now(),
        reply: Message(
          id: '2',
          senderId: '0',
          content: 'Hii',
          createdAt: DateTime.now(),
        ),
      ),
      Message(
        id: '3',
        senderId: '0',
        content: 'How R U',
        attachments: [],
        createdAt: DateTime.now(),
      ),
      Message(
        id: '4',
        senderId: '1',
        content: 'Fine',
        createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Message &&
            other.runtimeType == runtimeType &&
            other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}
