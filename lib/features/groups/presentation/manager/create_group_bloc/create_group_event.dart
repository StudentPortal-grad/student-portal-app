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
  final bool removeImage;

  UploadGroupImage({this.removeImage = false});
}

class CreateGroupRequestEvent extends CreateGroupEvent {
  final CreateGroupDto createGroupDto;

  CreateGroupRequestEvent(this.createGroupDto);
}
