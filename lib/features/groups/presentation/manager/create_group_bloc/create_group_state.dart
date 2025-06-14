part of 'create_group_bloc.dart';

@immutable
sealed class CreateGroupState {}

final class CreateGroupInitial extends CreateGroupState {}

final class GetSiblingsUserLoading extends CreateGroupState {}

final class GetSiblingsUserLoaded extends CreateGroupState {
  final List<UserSibling> siblingsUser;

  GetSiblingsUserLoaded(this.siblingsUser);
}

final class GetSiblingsUserFailed extends CreateGroupState {
  final String message;

  GetSiblingsUserFailed(this.message);
}

final class AddOrRemoveUsersState extends CreateGroupState {
  final List<UserSibling> selectedUsers;

  AddOrRemoveUsersState(this.selectedUsers);
}

final class UploadGroupImageState extends CreateGroupState {}