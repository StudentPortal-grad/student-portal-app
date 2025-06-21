import 'package:student_portal/features/resource/data/model/resource.dart';

class ResourceEntity extends Resource {
  const ResourceEntity({
    super.id,
    super.title,
    super.upVotesCount,
    super.downVotesCount,
    super.currentVote,
    super.description,
    super.fileUrl,
    super.fileSize,
    super.fileType,
    super.tags,
    super.uploader,
  });

  factory ResourceEntity.fromJson(Map<String, dynamic> json) {
    return ResourceEntity(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      fileSize: json["fileSize"],
      fileUrl: json["fileUrl"],
      fileType: json["fileType"],
      upVotesCount: json["upvotesCount"],
      downVotesCount: json["downvotesCount"],
      currentVote: json["currentVote"],
      tags: json["tags"] != null ? List<String>.from(json["tags"]) : null,
      uploader:
          json["uploader"] != null ? Uploader.fromJson(json["uploader"]) : null,
    );
  }
}
