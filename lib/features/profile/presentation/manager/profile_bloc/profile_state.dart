part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileSuccessState extends ProfileState {
  final User user;

  ProfileSuccessState(this.user);
}

final class ProfileFailureState extends ProfileState {
  final Failure failure;

  ProfileFailureState(this.failure);
}
