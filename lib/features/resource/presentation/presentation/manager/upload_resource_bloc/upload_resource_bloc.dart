import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/resource/presentation/data/dto/upload_resource.dart';

import '../../../../../../core/helpers/file_service.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../domain/repo/resource_repository.dart';
import '../../../domain/usecases/upload_resources.dart';

part 'upload_resource_event.dart';

part 'upload_resource_state.dart';

class UploadResourceBloc
    extends Bloc<UploadResourceEvent, UploadResourceState> {
  UploadResourceBloc() : super(UploadResourceInitial()) {
    on<UploadResourceRequest> (_resourceUploadRequest);
    on<UploadingResourceFiles>(_uploadImage);
    on<RemoveResourceFiles>(_removeImage);
    on<AddingResourceTags>(_choosingTags);
    on<AddingResourceCategory>(_choosingCategory);
    on<AddingResourceVisibility>(_choosingVisibility);
  }

  final UploadResources uploadResourceUc =
      UploadResources(getIt<ResourceRepository>());

  Future<void> _resourceUploadRequest(
      UploadResourceRequest event, Emitter<UploadResourceState> emit) async {
    emit(UploadResourceLoading());
    var data = await uploadResourceUc.call(
      resourceDto: event.resourceDto,
      onProgress: (percent) {
        emit(UploadResourceProgressLoading(percent));
      },
    );
    data.fold(
      (error) => emit(UploadResourceFailed(error.message ?? 'Unknown error')),
      (response) => emit(UploadResourceLoaded(response)),
    );
  }
  List<String> paths = [];

  Future<void> _uploadImage(
      UploadingResourceFiles event, Emitter<UploadResourceState> emit) async {
    try {
      List<File?>? files = await FileService.pickFiles();
      if (files.isEmpty) return;
      for (var file in files) {
        final String path = file!.path.trim();
        debugPrint("FILE PATH::: $path");
        paths.add(path);
      }
      emit(UploadedImagesState());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> _removeImage(
      RemoveResourceFiles event, Emitter<UploadResourceState> emit) async {
    paths.remove(event.filePath);
    emit(RemoveImagesState());
  }

  List<String> tags = [];

  Future<void> _choosingTags(
      AddingResourceTags event, Emitter<UploadResourceState> emit) async {
    tags = event.tags.toList();
    emit(ChooseTagsState());
  }

  String? category;
  String? visibility;

  Future<void> _choosingCategory(
      AddingResourceCategory event, Emitter<UploadResourceState> emit) async {
    category = event.category;
    emit(ChooseCategoryState());
  }

  Future<void> _choosingVisibility(
      AddingResourceVisibility event, Emitter<UploadResourceState> emit) async {
    visibility = event.visibility;
    emit(ChooseVisibilityState());
  }
}
