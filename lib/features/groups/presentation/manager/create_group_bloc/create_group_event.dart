part of 'create_group_bloc.dart';

@immutable
sealed class CreateGroupEvent {}

class GetUsersSiblings extends CreateGroupEvent {}

class AddOrRemoveUsers extends CreateGroupEvent {
  final UserSibling userSibling;

  AddOrRemoveUsers(this.userSibling);
}

class UploadGroupImage extends CreateGroupEvent {
  final String imagePath;

  UploadGroupImage(this.imagePath);
}

class CreateGroup extends CreateGroupEvent {}
