import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/groups/data/models/user_sibling.dart';
import 'package:student_portal/features/groups/domain/usecases/get_users_siblings_uc.dart';

import '../../../../../core/helpers/file_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../domain/repo/group_repository.dart';

part 'create_group_event.dart';

part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  CreateGroupBloc() : super(CreateGroupInitial()) {
    on<GetUsersSiblings>(_getUsersSiblings);
    on<AddOrRemoveUsers>(_addOrRemoveUsers);
    on<UploadGroupImage>(_uploadGroupImage);
  }

  final GetUsersSiblingsUc _getUsersSiblingsUc = GetUsersSiblingsUc(getIt<GroupRepository>());
  Set<UserSibling> selectedUsers = {};
  String? groupImagePath;

  Future<void> _getUsersSiblings(GetUsersSiblings event, Emitter<CreateGroupState> emit) async {
    emit(GetSiblingsUserLoading());
    final result = await _getUsersSiblingsUc.getUsersSiblings();
    result.fold(
      (error) => emit(GetSiblingsUserFailed(error.message ?? 'Something went wrong')),
      (users) => emit(GetSiblingsUserLoaded(users)),
    );
  }

  Future<void> _addOrRemoveUsers(AddOrRemoveUsers event, Emitter<CreateGroupState> emit) async {
    if (event.isAdding) {
      selectedUsers.add(event.userSibling);
    } else {
      selectedUsers.remove(event.userSibling);
    }
    emit(AddOrRemoveUsersState(selectedUsers.toList()));
  }

  Future<void> _uploadGroupImage(UploadGroupImage event, Emitter<CreateGroupState> emit) async {
    try {
      if (event.removeImage) {
        groupImagePath = null;
      } else {
        groupImagePath = (await FileService.pickImage())?.path ?? groupImagePath;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    emit(UploadGroupImageState());
  }
}
