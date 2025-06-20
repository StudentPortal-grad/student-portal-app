import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/core/utils/service_locator.dart';
import 'package:student_portal/features/profile/domain/repo/profile_repository.dart';
import 'package:student_portal/features/profile/domain/use_case/follow_user_uc.dart';

part 'follow_event.dart';

part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  FollowBloc(this.isFollowing) : super(FollowInitial()) {
    on<FollowUserEvent>(_followUser);
    on<UnFollowUserEvent>(_unfollowUser);
  }
  bool? isFollowing;
  final FollowUserUc followUserUc = FollowUserUc(getIt<ProfileRepository>());

  Future<void> _followUser(FollowUserEvent event, Emitter<FollowState> emit) async {
    emit(FollowLoading());
    var data = await followUserUc.follow(userId: event.userId);
    data.fold(
      (error) => emit(FollowFailed(error.message ?? "Something went wrong")),
      (response) {
        isFollowing = true;
        emit(FollowSuccess(response));
      },
    );
  }

  Future<void> _unfollowUser(UnFollowUserEvent event, Emitter<FollowState> emit) async {
    emit(UnFollowLoading());
    var data = await followUserUc.unfollow(userId: event.userId);
    data.fold(
      (error) => emit(UnFollowFailed(error.message ?? "Something went wrong")),
      (response) {
        isFollowing = false;
        emit(UnFollowSuccess(response));
      },
    );
  }
}
