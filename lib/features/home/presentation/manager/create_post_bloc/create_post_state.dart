part of 'create_post_bloc.dart';

@immutable
sealed class CreatePostState {}

final class CreatePostInitial extends CreatePostState {}

final class CreatePostLoading extends CreatePostState {}

final class CreatePostUploading extends CreatePostState {
  final int percent;

  CreatePostUploading(this.percent);
}

final class CreatePostLoaded extends CreatePostState {
  final String message;

  CreatePostLoaded(this.message);
}

final class CreatePostFailed extends CreatePostState {
  final String message;

  CreatePostFailed(this.message);
}

final class UploadedImagesState extends CreatePostState {}

final class RemoveImagesState extends CreatePostState {}

final class ChooseTagsState extends CreatePostState {}

