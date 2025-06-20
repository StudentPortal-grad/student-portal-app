import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/features/chats/data/dto/attachment_dto.dart';
import 'package:student_portal/features/chats/data/model/message.dart';
import 'package:student_portal/features/chats/domain/repo/messaging_repo.dart';
import 'package:student_portal/features/chats/domain/usecases/listen_new_message_uc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../data/dto/message_dto.dart';
import '../../../data/model/conversation.dart';
import '../../../domain/usecases/get_conversation_uc.dart';
import '../../../domain/usecases/send_message_uc.dart';

part 'conversation_event.dart';

part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc({this.conversation}) : super(ConversationInitial()) {
    on<GetConversationEvent>(_onGetConversationEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
    on<SendAttachedMessageEvent>(_onSendAttachedMessageEvent);
    on<NewMessageReceivedEvent>(_onNewMessageReceived);
  }

  // usecases
  final GetConversationUc getConversationUc = GetConversationUc(messagingRepo: getIt.get<MessagingRepo>());
  final SendMessageUc sendMessageUc = SendMessageUc(messagingRepo: getIt.get<MessagingRepo>());
  final ListenToNewMessageUseCase listenToNewMessageUseCase = ListenToNewMessageUseCase(getIt.get<MessagingRepo>());

  StreamSubscription<Message>? _newMessageSubscription;

  List<Message> chats = [];
  Conversation? conversation;

  // methods
  Future<void> _onGetConversationEvent(GetConversationEvent event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading());
    final result = await getConversationUc.call(id: event.conversationId);
    result.fold(
      (error) => emit(ConversationFailed(error.message ?? 'Something went wrong')),
      (model) {
        chats.clear();
        chats.addAll(model.messages ?? []);
        conversation = conversation ?? model.conversation;
        _startListeningToNewMessages();
        emit(ConversationLoaded(chats: chats));
      },
    );
  }

  void _startListeningToNewMessages() {
    if (_newMessageSubscription != null) return; // Already listening
    _newMessageSubscription = listenToNewMessageUseCase.call().listen((message) {
      log('New message received: ${message.toJson()}');
      add(NewMessageReceivedEvent(message));
    });
  }

  Future<void> _onNewMessageReceived(NewMessageReceivedEvent event, Emitter<ConversationState> emit) async {
    final index = chats.indexWhere((m) =>
    m.uploading == true &&
        m.conversationId == event.message.conversationId &&
        m.sender?.id == event.message.sender?.id &&
        m.content == event.message.content);

    if (index != -1) {
      chats[index] = event.message;
    } else {
      chats.insert(0, event.message);
    }

    emit(ConversationLoaded(chats: chats));
  }

  Future<void> _onSendMessageEvent(SendMessageEvent event, Emitter<ConversationState> emit) async {
    // Insert the temp "sending" message immediately
    chats.insert(0, event.message);
    emit(ConversationLoaded(chats: List.from(chats)));

    sendMessageUc.call(event.messageDto.toJson());
  }

  Future<void> _onSendAttachedMessageEvent(SendAttachedMessageEvent event, Emitter<ConversationState> emit) async {
    final me = UserRepository.user;
    chats.insert(0, event.message ?? Message(
      sender: Sender(
        id: me?.id ?? '',
        name: me?.name ?? '',
        profilePicture: me?.profilePicture ?? '',
      ),
    ));
    emit(ConversationLoaded(chats: List.from(chats)));
    final result = await sendMessageUc.sendAttachment(event.attachmentDto);
    result.fold(
      (error) => emit(ConversationFailed(error.message ?? 'Something went wrong')),
      (model) {
        chats.removeWhere((message) => message.id == model.id);
        chats.insert(0, model);
        emit(ConversationLoaded(chats: List.from(chats)));
      },
    );
  }

  @override
  Future<void> close() {
    _newMessageSubscription?.cancel();
    return super.close();
  }
}
