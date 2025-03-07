import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../auth/data/model/user_model/user.dart';
import '../../../data/reoi_impl/get_my_profile_impl.dart';
import '../../../domain/usecase/get_my_profile_us.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetMyProfileEvent>(_getMyProfile);
  }

  final GetMyProfileUs getMyProfileUs = GetMyProfileUs(
      getMyProfileRepo: GetMyProfileImpl(getIt.get<ApiService>()));

  Future<void> _getMyProfile(
      GetMyProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    var data = await getMyProfileUs.call();
    data.fold(
      (error) => emit(ProfileFailureState(error)),
      (response) => emit(ProfileSuccessState(response)),
    );
  }
}
