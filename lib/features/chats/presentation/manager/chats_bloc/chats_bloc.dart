import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/api_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/model/conversation.dart';
import '../../../data/repo_impl/messaging_impl.dart';
import '../../../domain/usecases/get_chats.dart';

part 'chats_event.dart';

part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetChatsUc getConversationUc = GetChatsUc(messagingRepo: MessagingImpl(getIt.get<ApiService>()));
  final List<Conversation> _conversations = [];

  StreamSubscription? _subscription;

  ChatsBloc() : super(ChatsInitial()) {
    on<StartListeningToConversations>(_onStartListening);
    on<NewConversationReceived>(_onNewConversation);
  }

  void _onStartListening(
      StartListeningToConversations event, Emitter<ChatsState> emit) {
    log('Starting to listen to conversations');
    _subscription = getConversationUc.call().listen(
      (conversations) {
        add(NewConversationReceived(conversations));
      },
    );
  }

  void _onNewConversation(NewConversationReceived event,
      Emitter<ChatsState> emit) {
    _conversations.clear();
    _conversations.addAll(event.conversation);
    emit(ChatsStreamUpdated(List.from(_conversations)));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    getConversationUc.dispose();
    return super.close();
  }
}
