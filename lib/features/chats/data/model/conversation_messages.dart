import 'package:student_portal/features/chats/data/model/conversation.dart';
import 'package:student_portal/features/chats/data/model/message.dart';

class ConversationMessages {
  final List<Message>? messages;
  final Conversation? conversation;

  ConversationMessages({this.messages, this.conversation});

  factory ConversationMessages.fromJson(Map<String, dynamic> json) {
    final dynamic data = json['data'];

    if (data is List) {
      return ConversationMessages(
        messages: data
            .map<Message>((e) => Message.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } else if (data is Map<String, dynamic>) {
      return ConversationMessages(
        messages: (data['messages'] as List)
            .map<Message>((e) => Message.fromJson(e as Map<String, dynamic>))
            .toList(),
        conversation: data['conversation'] != null
            ? Conversation.fromJson(data['conversation'])
            : null,
      );
    } else {
      throw Exception("Unexpected data format in ConversationMessages");
    }
  }
}
