import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_portal/features/home/domain/usecases/create_post_uc.dart';

import '../../../../../core/helpers/file_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/dto/post_dto.dart' show PostDto;
import '../../../domain/repo/posts_repository.dart';

part 'create_post_event.dart';

part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(CreatePostInitial()) {
    on<CreatePostRequested>(_createPostRequested);
    on<UploadingPostImages>(_uploadImage);
    on<RemovePostImages>(_removeImage);
    on<AddingPostTags>(_choosingTags);
  }

  final CreatePostUc createPostUc = CreatePostUc(getIt<PostRepository>());

  Future<void> _createPostRequested(
      CreatePostRequested event, Emitter<CreatePostState> emit) async {
    emit(CreatePostLoading());
    var data = await createPostUc.call(
      postDto: event.postDto,
      onProgress: (percent) {
        emit(CreatePostUploading(percent));
      },
    );
    data.fold(
      (error) => emit(CreatePostFailed(error.message ?? 'Unknown error')),
      (response) => emit(CreatePostLoaded(response)),
    );
  }

  List<String> paths = [];

  Future<void> _uploadImage(
      UploadingPostImages event, Emitter<CreatePostState> emit) async {
    try {
      List<File?>? files = await FileService.pickImages();
      if (files?.isEmpty ?? true) return;
      files?.forEach((file){
        final String path = file!.path.trim();
        debugPrint("FILE PATH::: $path");
        paths.add(path);
      });
      emit(UploadedImagesState());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> _removeImage(
      RemovePostImages event, Emitter<CreatePostState> emit) async {
    paths.remove(event.filePath);
    emit(RemoveImagesState());
  }

  List<String> tags = [];

  Future<void> _choosingTags(
      AddingPostTags event, Emitter<CreatePostState> emit) async {
    tags = event.tags.toList();
    emit(ChooseTagsState());
  }
}
