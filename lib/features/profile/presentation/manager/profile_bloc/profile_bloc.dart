import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/profile/domain/use_case/get_user_profile_uc.dart';

import '../../../../../core/errors/data/model/error_model.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../auth/data/model/user_model/user.dart';
import '../../../data/dto/change_password_dto.dart';
import '../../../data/dto/update_profile_dto.dart';
import '../../../domain/repo/profile_repository.dart';
import '../../../domain/use_case/change_password_uc.dart';
import '../../../domain/use_case/get_my_profile_us.dart';
import '../../../domain/use_case/update_my_profile_uc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetMyProfileEvent>(_getMyProfile);
    on<GetUserProfileEvent>(_getUserProfile);
    on<UpdateMyProfileEvent>(_updateMyProfile);
    on<ChangePasswordEvent> (_changePassword);
  }

// usecases
  final GetMyProfileUs getMyProfileUs = GetMyProfileUs(profileRepository: getIt<ProfileRepository>());
  final GetUserProfileUc getUserProfileUs = GetUserProfileUc(profileRepository: getIt<ProfileRepository>());
  final UpdateMyProfileUC updateMyProfileUC = UpdateMyProfileUC(profileRepository: getIt<ProfileRepository>());
  final ChangePasswordUc changePasswordUc = ChangePasswordUc(profileRepository: getIt<ProfileRepository>());

  Future<void> _getMyProfile(
      GetMyProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    var data = await getMyProfileUs.call();
    data.fold(
      (error) => emit(ProfileFailureState(error)),
      (response) => emit(ProfileSuccessState(response)),
    );
  }

  Future<void> _getUserProfile(
      GetUserProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    var data = await getUserProfileUs.call(userId: event.userId);
    data.fold(
      (error) => emit(ProfileFailureState(error)),
      (response) => emit(ProfileSuccessState(response)),
    );
  }

  Future<void> _updateMyProfile(
      UpdateMyProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    var data = await updateMyProfileUC.call(event.updateProfileDto);
    data.fold(
      (error) => emit(ProfileFailureState(error)),
      (response) => emit(ProfileSuccessState(response)),
    );
  }
  Future<void> _changePassword(
      ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    var data = await changePasswordUc.call(event.changePasswordDto);
    data.fold(
          (error) => emit(ChangePasswordFailureState(error)),
          (response) => emit(ChangePasswordSuccessState(response)),
    );
  }
}
