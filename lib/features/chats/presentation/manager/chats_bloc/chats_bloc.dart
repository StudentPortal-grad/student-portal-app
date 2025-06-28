import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/api_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/model/conversation.dart';
import '../../../data/repo_impl/messaging_impl.dart';
import '../../../domain/usecases/get_chats.dart';

part 'chats_event.dart';

part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {

  ChatsBloc() : super(ChatsInitial()) {
    on<StartListeningToConversations>(_onStartListening);
    on<NewConversationReceived>(_onNewConversation);
  }

  final GetChatsUc getConversationUc = GetChatsUc(messagingRepo: MessagingImpl(getIt.get<ApiService>()));

  final List<Conversation> _conversations = [];
  StreamSubscription? _subscription;

  void _onStartListening(StartListeningToConversations event, Emitter<ChatsState> emit) async {
    log('Starting to listen to conversations');
    emit(ChatsLoading());

    await _subscription?.cancel(); // Cancel any previous stream
    try {
      _subscription = getConversationUc.call().listen((conversations) {
          add(NewConversationReceived(conversations));
        },
        onError: (error) {
          log('ChatsBloc caught exception:: $error');
          emit(ChatsError(error.toString()));
        },
      );
      add(NewConversationReceived(_conversations));
    } catch (e) {
      log('ChatsBloc caught exception: $e');
      emit(ChatsError(e.toString()));
    }
  }

  void _onNewConversation(NewConversationReceived event, Emitter<ChatsState> emit) {
    _conversations..clear()..addAll(event.conversation);
    emit(ChatsStreamUpdated(List.from(_conversations)));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    getConversationUc.dispose();
    return super.close();
  }
}
