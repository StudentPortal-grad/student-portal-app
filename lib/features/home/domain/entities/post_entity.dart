import '../../data/model/post_model/attachment.dart';
import '../../data/model/post_model/creator.dart';
import '../../data/model/post_model/post.dart';

class PostEntity extends Discussion{

  const PostEntity({
    super.id,
    super.title,
    super.upVotesCount,
    super.downVotesCount,
    super.content,
    super.attachments,
    super.creator,
    super.currentVote,
  });

  factory PostEntity.fromJson(Map<String,dynamic> json){
    return PostEntity(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      creator:
      json['creator'] != null ? Creator.fromJson(json['creator']) : null,
      attachments: (json['attachments'] as List?)
          ?.map((e) => Attachment.fromJson(e))
          .toList(),
      downVotesCount: json['downvotesCount'],
      upVotesCount: json['upvotesCount'],
      currentVote: json['currentVote']
    );
  }
}
