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

class UpdateMyProfileEvent extends ProfileEvent {
  final UpdateProfileDto updateProfileDto;

  UpdateMyProfileEvent({required this.updateProfileDto});
}

class ChangePasswordEvent extends ProfileEvent {
  final ChangePasswordDto changePasswordDto;

  ChangePasswordEvent({required this.changePasswordDto});
}
