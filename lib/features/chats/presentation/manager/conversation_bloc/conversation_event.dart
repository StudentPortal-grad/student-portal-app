part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}

final class GetConversationEvent extends ConversationEvent {
  final String conversationId;

  GetConversationEvent({required this.conversationId});
}

final class SendMessageEvent extends ConversationEvent {
  final MessageDto messageDto;
  final Message message;

  SendMessageEvent({required this.messageDto,required this.message});
}


final class SendAttachedMessageEvent extends ConversationEvent {
  final AttachmentDto attachmentDto;
  final Message? message;

  SendAttachedMessageEvent({required this.attachmentDto, this.message});
}

final class NewMessageReceivedEvent extends ConversationEvent {
  final Message message;

  NewMessageReceivedEvent(this.message);
}
