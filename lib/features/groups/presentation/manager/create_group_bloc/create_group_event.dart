part of 'create_group_bloc.dart';

@immutable
sealed class CreateGroupEvent {}

class GetUsersSiblings extends CreateGroupEvent {}

class AddOrRemoveUsers extends CreateGroupEvent {
  final UserSibling userSibling;
  final bool isAdding;

  AddOrRemoveUsers(this.userSibling, {this.isAdding = true});
}

class UploadGroupImage extends CreateGroupEvent {
  final String imagePath;

  UploadGroupImage(this.imagePath);
}

class CreateGroup extends CreateGroupEvent {}
