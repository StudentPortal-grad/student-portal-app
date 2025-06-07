part of 'upload_resource_bloc.dart';

@immutable
sealed class UploadResourceEvent {}

class UploadResourceRequest extends UploadResourceEvent {
  final ResourceDto resourceDto;

  UploadResourceRequest(this.resourceDto);
}


class UploadingResourceFiles extends UploadResourceEvent {}

class RemoveResourceFiles extends UploadResourceEvent {
  final String filePath;

  RemoveResourceFiles(this.filePath);
}

class AddingResourceTags extends UploadResourceEvent {
  final Set<String> tags;

  AddingResourceTags(this.tags);
}

class AddingResourceCategory extends UploadResourceEvent {
  final String category;

  AddingResourceCategory(this.category);
}

class AddingResourceVisibility extends UploadResourceEvent {
  final String visibility;

  AddingResourceVisibility(this.visibility);
}
