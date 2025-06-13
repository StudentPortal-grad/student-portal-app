import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/chats/data/model/message.dart';
import 'package:student_portal/features/chats/domain/repo/messaging_repo.dart';
import 'package:student_portal/features/chats/domain/usecases/listen_new_message_uc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../data/dto/message_dto.dart';
import '../../../domain/usecases/get_conversation_uc.dart';
import '../../../domain/usecases/send_message_uc.dart';

part 'conversation_event.dart';

part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial()) {
    on<GetConversationEvent>(_onGetConversationEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
    on<NewMessageReceivedEvent>(_onNewMessageReceived);
  }

  // usecases
  final GetConversationUc getConversationUc = GetConversationUc(messagingRepo: getIt.get<MessagingRepo>());
  final SendMessageUc sendMessageUc = SendMessageUc(messagingRepo: getIt.get<MessagingRepo>());
  final ListenToNewMessageUseCase listenToNewMessageUseCase = ListenToNewMessageUseCase(getIt.get<MessagingRepo>());

  StreamSubscription<Message>? _newMessageSubscription;

  List<Message> chats = [];

  // methods
  Future<void> _onGetConversationEvent(GetConversationEvent event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading());
    final result = await getConversationUc.call(id: event.conversationId);
    result.fold(
      (error) => emit(ConversationFailed(error.message ?? 'Something went wrong')),
      (messages) {
        chats.clear();
        chats.addAll(messages);
        _startListeningToNewMessages();
        emit(ConversationLoaded(chats: messages));
      },
    );
  }

  void _startListeningToNewMessages() {
    if (_newMessageSubscription != null) return; // Already listening
    _newMessageSubscription = listenToNewMessageUseCase.call().listen((message) {
      log('New message received: $message');
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

  @override
  Future<void> close() {
    _newMessageSubscription?.cancel();
    return super.close();
  }
}
