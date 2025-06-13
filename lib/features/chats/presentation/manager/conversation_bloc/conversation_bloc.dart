import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/chats/data/model/message.dart';
import 'package:student_portal/features/chats/data/repo_impl/messaging_impl.dart';

import '../../../../../core/network/api_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../domain/usecases/get_conversation_uc.dart';
import '../../../domain/usecases/send_message_uc.dart';

part 'conversation_event.dart';

part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial()) {
    on<GetConversationEvent>(_onGetConversationEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  // usecases
  final GetConversationUc getConversationUc = GetConversationUc(messagingRepo: MessagingImpl(getIt.get<ApiService>()));
  final SendMessageUc sendMessageUc = SendMessageUc(messagingRepo: MessagingImpl(getIt.get<ApiService>()));
  List<Message> chats = [];

  // methods
  Future<void> _onGetConversationEvent(GetConversationEvent event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading());
    final result = await getConversationUc.call(id: event.conversationId);
    result.fold(
      (error) => emit(ConversationFailed(error.message ?? 'Something went wrong')),
      (messages) {
        chats = messages;
        emit(ConversationLoaded(chats: messages));
      },
    );
  }

  Future<void> _onSendMessageEvent(
      SendMessageEvent event, Emitter<ConversationState> emit) async {}
}
