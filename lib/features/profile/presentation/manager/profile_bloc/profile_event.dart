part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetMyProfileEvent extends ProfileEvent {
  final bool refresh;

  GetMyProfileEvent({this.refresh = true});
}

class GetUserProfileEvent extends ProfileEvent {
  final String userId;

  GetUserProfileEvent({required this.userId});
}

class UpdateMyProfileDataEvent extends ProfileEvent {}

class UpdateMyPersonalDataEvent extends ProfileEvent {}

class UpdateMyAcademicDataEvent extends ProfileEvent {}

class ChangePasswordEvent extends ProfileEvent {
  final ChangePasswordDto changePasswordDto;

  ChangePasswordEvent({required this.changePasswordDto});
}

class OnProfileImagePicked extends ProfileEvent {}
