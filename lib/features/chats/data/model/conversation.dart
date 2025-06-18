import 'package:student_portal/features/chats/data/model/participant.dart';
import '../../../../core/repo/user_repository.dart';
import 'message.dart';

class Conversation {
  final String? id;
  final String? type;
  final String? name;
  final String? groupImage;
  final List<Participant>? participants;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final Message? lastMessage;
  final ConversationMetadata? metadata;
  final ConversationSettings? settings;

  Conversation({
    this.id,
    this.type,
    this.participants,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
    this.metadata,
    this.settings,
    this.name,
    this.groupImage,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['_id'],
      type: json['type'],
      name: json['name'],
      groupImage: json['groupImage'],
      participants: (json['participants'] as List?)
              ?.map((p) => Participant.fromJson(p as Map<String, dynamic>)).toList() ?? [],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      lastMessage: json['lastMessage'] != null && json['lastMessage'] is Map
          ? Message.fromJson(json['lastMessage'])
          : null,
      metadata: ConversationMetadata.fromJson(json['metadata'] ?? {}),
      settings: ConversationSettings.fromJson(json['settings'] ?? {}),
    );
  }

  Participant? get getOtherParticipant {
    final currentUserId = UserRepository.user?.id;
    final others = participants
        ?.where((p) => p.userId?.id != currentUserId)
        .toList();

    return (others != null && others.isNotEmpty) ? others.first : null;
  }
}

class ConversationMetadata {
  final int? totalMessages;
  final String? lastActivity;

  ConversationMetadata({
    this.totalMessages,
    this.lastActivity,
  });

  factory ConversationMetadata.fromJson(Map<String, dynamic> json) {
    return ConversationMetadata(
      totalMessages: json['totalMessages'],
      lastActivity: json['lastActivity'],
    );
  }
}

class ConversationSettings {
  final SlowMode? slowMode;
  final bool? onlyAdminsCanPost;
  final bool? onlyAdminsCanAddMembers;
  final bool? onlyAdminsCanPinMessages;

  ConversationSettings({
    this.slowMode,
    this.onlyAdminsCanPost,
    this.onlyAdminsCanAddMembers,
    this.onlyAdminsCanPinMessages,
  });

  factory ConversationSettings.fromJson(Map<String, dynamic> json) {
    return ConversationSettings(
      slowMode: SlowMode.fromJson(json['slowMode'] ?? {}),
      onlyAdminsCanPost: json['onlyAdminsCanPost'],
      onlyAdminsCanAddMembers: json['onlyAdminsCanAddMembers'],
      onlyAdminsCanPinMessages: json['onlyAdminsCanPinMessages'],
    );
  }
}

class SlowMode {
  final bool? enabled;
  final int? interval;

  SlowMode({
    this.enabled,
    this.interval,
  });

  factory SlowMode.fromJson(Map<String, dynamic> json) {
    return SlowMode(
      enabled: json['enabled'],
      interval: json['interval'],
    );
  }
}
