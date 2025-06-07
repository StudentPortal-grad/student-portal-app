part of 'upload_resource_bloc.dart';

@immutable
sealed class UploadResourceState {}

final class UploadResourceInitial extends UploadResourceState {}

final class UploadResourceLoading extends UploadedImagesState {}

final class UploadResourceProgressLoading extends UploadedImagesState {
  final int percent;

  UploadResourceProgressLoading(this.percent);
}

final class UploadResourceLoaded extends UploadedImagesState {
  final String message;

  UploadResourceLoaded(this.message);
}

final class UploadResourceFailed extends UploadedImagesState {
  final String message;

  UploadResourceFailed(this.message);
}

final class UploadedImagesState extends UploadResourceState {}

final class RemoveImagesState extends UploadResourceState {}

final class ChooseTagsState extends UploadResourceState {}

final class ChooseCategoryState extends UploadedImagesState {}

final class ChooseVisibilityState extends UploadedImagesState {}
