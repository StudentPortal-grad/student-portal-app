import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/profile/domain/usecase/get_user_profile_uc.dart';

import '../../../../../core/errors/data/model/error_model.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../auth/data/model/user_model/user.dart';
import '../../../data/dto/update_profile_dto.dart';
import '../../../data/reoi_impl/profile_repository_impl.dart';
import '../../../domain/usecase/get_my_profile_us.dart';
import '../../../domain/usecase/update_my_profile_uc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetMyProfileEvent>(_getMyProfile);
    on<GetUserProfileEvent>(_getUserProfile);
    on<UpdateMyProfileEvent>(_updateMyProfile);
  }

// usecases
  final GetMyProfileUs getMyProfileUs = GetMyProfileUs(
      getMyProfileRepo: ProfileRepositoryImpl(getIt.get<ApiService>()));
  final GetUserProfileUc getUserProfileUs = GetUserProfileUc(
      profileRepository: ProfileRepositoryImpl(getIt.get<ApiService>()));
  final UpdateMyProfileUC updateMyProfileUC = UpdateMyProfileUC(
      profileRepository: ProfileRepositoryImpl(getIt.get<ApiService>()));

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
}
