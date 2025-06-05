part of 'create_post_bloc.dart';

@immutable
sealed class CreatePostEvent {}

class CreatePostRequested extends CreatePostEvent {
  final PostDto postDto;

  CreatePostRequested(this.postDto);
}

class UploadingPostImages extends CreatePostEvent {}

class RemovePostImages extends CreatePostEvent {
  final String filePath;

  RemovePostImages(this.filePath);
}

class AddingPostTags extends CreatePostEvent {
  final Set<String> tags;

  AddingPostTags(this.tags);
}
