part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetMyProfileEvent extends ProfileEvent {}

class GetUserProfileEvent extends ProfileEvent {
  final String userId;

  GetUserProfileEvent({required this.userId});
}

class UpdateMyProfileEvent extends ProfileEvent {
  final UpdateProfileDto updateProfileDto;

  UpdateMyProfileEvent({required this.updateProfileDto});
}
