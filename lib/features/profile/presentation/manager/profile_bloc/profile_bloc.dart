import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/features/profile/domain/use_case/get_user_profile_uc.dart';

import '../../../../../core/errors/data/model/error_model.dart';
import '../../../../../core/helpers/file_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../auth/data/model/user_model/profile.dart';
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
    on<UpdateMyProfileDataEvent>(_updateMyProfileData);
    on<UpdateMyPersonalDataEvent>(_updatePersonalData);
    on<UpdateMyAcademicDataEvent>(_updateAcademicData);
    on<ChangePasswordEvent>(_changePassword);
    on<OnProfileImagePicked>(_onPickProfileImage);
  }

//formKey
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> academicFormKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();

// Change Password
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Profile Controllers
  final TextEditingController nameController =
      TextEditingController(text: UserRepository.user?.name ?? '');
  final TextEditingController userNameController =
      TextEditingController(text: UserRepository.user?.username ?? '');
  final TextEditingController phoneController =
      TextEditingController(text: UserRepository.user?.phoneNumber);
  final TextEditingController bioController =
      TextEditingController(text: UserRepository.user?.profile?.bio);
  PhoneNumber? phoneNumber;

  final TextEditingController dateOfBirthController = TextEditingController(text: UserRepository.user?.dateOfBirth != null ? DateFormat('dd/MM/yyyy').format(UserRepository.user!.dateOfBirth!) : '');
  String? dateOfBirth;
  String? gender = UserRepository.user?.gender;
  String? profileImage;

  // academic Controllers
  final TextEditingController universityController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController gpaController =
      TextEditingController(text: UserRepository.user?.gpa?.toString());
  final TextEditingController levelController =
      TextEditingController(text: UserRepository.user?.level?.toString());
  String? position;

// usecases
  final GetMyProfileUs getMyProfileUs =
      GetMyProfileUs(profileRepository: getIt<ProfileRepository>());
  final GetUserProfileUc getUserProfileUs =
      GetUserProfileUc(profileRepository: getIt<ProfileRepository>());
  final UpdateMyProfileUC updateMyProfileUC =
      UpdateMyProfileUC(profileRepository: getIt<ProfileRepository>());
  final ChangePasswordUc changePasswordUc =
      ChangePasswordUc(profileRepository: getIt<ProfileRepository>());

  Future<void> _getMyProfile(
      GetMyProfileEvent event, Emitter<ProfileState> emit) async {
    if (!event.refresh && UserRepository.user != null) {
      emit(ProfileSuccessState(UserRepository.user!));
      return;
    }
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

  Future<void> _updateMyProfileData(
      UpdateMyProfileDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    var data = await updateMyProfileUC.call(UpdateProfileDto(
      name: nameController.text,
      userName: userNameController.text,
      profile: Profile(bio: bioController.text),
      profilePicture: profileImage,
    ));
    data.fold(
      (error) => emit(ProfileFailureState(error)),
      (response) => emit(ProfileSuccessState(response)),
    );
  }

  Future<void> _updatePersonalData(
      UpdateMyPersonalDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    var data = await updateMyProfileUC.call(
      UpdateProfileDto(
        gender: gender,
        phoneNumber: phoneNumber?.phoneNumber,
        dateOfBirth: dateOfBirth,
      ),
    );
    data.fold(
      (error) => emit(ProfileFailureState(error)),
      (response) => emit(ProfileSuccessState(response)),
    );
  }

  Future<void> _updateAcademicData(
      UpdateMyAcademicDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    var data = await updateMyProfileUC.call(UpdateProfileDto(
      name: nameController.text,
      userName: userNameController.text,
      profile: Profile(bio: bioController.text),
      profilePicture: profileImage,
    ));
    data.fold(
      (error) => emit(ProfileFailureState(error)),
      (response) => emit(ProfileSuccessState(response)),
    );
  }

  Future<void> _changePassword(
      ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    emit(ChangePasswordLoadingState());
    var data = await changePasswordUc.call(event.changePasswordDto);
    data.fold(
      (error) => emit(ChangePasswordFailureState(error)),
      (response) => emit(ChangePasswordSuccessState(response)),
    );
  }

  Future<void> _onPickProfileImage(
      OnProfileImagePicked event, Emitter<ProfileState> emit) async {
    profileImage = (await FileService.pickImage())?.path;
    emit(OnPickProfileImageState());
  }

  @override
  Future<void> close() {
    confirmPasswordController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    return super.close();
  }
}
