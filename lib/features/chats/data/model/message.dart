import 'package:intl/intl.dart';

import 'attachment.dart';

class Message {
  const Message({
    this.id,
    this.conversationId,
    this.content,
    this.sender,
    this.attachments,
    this.createdAt,
    this.updatedAt,
    this.status = "sent",
    this.reply,
    this.uploading = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'] as String?,
      conversationId: json['conversationId'] as String?,
      content: json['content'] as String?,
      sender: json['sender'] != null
          ? Sender.fromJson(json['sender'])
          : json['senderId'] != null && json['senderId'] is Map<String, dynamic>
              ? Sender.fromJson(json['senderId'])
              : null,
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => Attachment.fromJson(e as Map<String, dynamic>)).toList(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      status: json['status'] as String? ?? "sent",
      reply: json['reply'] != null ? Message.fromJson(json['reply']) : null,
    );
  }

  final String? id;
  final String? conversationId;
  final String? content;
  final Sender? sender;
  final List<Attachment>? attachments;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final Message? reply;
  final bool uploading;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'conversationId': conversationId,
      'content': content,
      'sender': sender?.toJson(),
      'attachments': attachments?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'status': status,
      'reply': reply?.toJson(),
    };
  }

  String formattedTime() {
    if(createdAt == null) return "";
    return DateFormat.jm().format(createdAt!.toLocal());
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

class Sender {
  const Sender({
    this.id,
    this.name,
    this.profilePicture,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'] as String,
      name: json['name'] as String,
      profilePicture: json['profilePicture'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'profilePicture': profilePicture,
    };
  }

  final String? id;
  final String? name;
  final String? profilePicture;
}
