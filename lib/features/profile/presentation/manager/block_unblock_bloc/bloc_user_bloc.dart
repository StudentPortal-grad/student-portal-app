import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../domain/repo/profile_repository.dart';
import '../../../domain/use_case/block_user_uc.dart';

part 'bloc_user_event.dart';

part 'bloc_user_state.dart';

class BlockUserBloc extends Bloc<BlockUserEvent, BlockUserState> {
  BlockUserBloc() : super(UserInitial()) {
    on<BlockUserEventRequest>(_blockUser);
    on<UnBlockUserEventRequest>(_unblockUser);
  }

  final BlockUserUc blockUserUc = BlockUserUc(getIt<ProfileRepository>());

  Future<void> _blockUser(BlockUserEventRequest event, Emitter<BlockUserState> emit) async {
    emit(BlockLoadingState());
    var data = await blockUserUc.block(userId: event.userId);
    data.fold(
      (error) => emit(BlockFailedState(error.message ?? "Something went wrong")),
      (response) => emit(BlockSuccessState(response)),
    );
  }

  Future<void> _unblockUser(UnBlockUserEventRequest event, Emitter<BlockUserState> emit) async {
    emit(UnBlockLoadingState());
    var data = await blockUserUc.unBlock(userId: event.userId);
    data.fold(
      (error) => emit(UnBlockFailedState(error.message ?? "Something went wrong")),
      (response) => emit(UnBlockSuccessState(response)),
    );
  }
}
