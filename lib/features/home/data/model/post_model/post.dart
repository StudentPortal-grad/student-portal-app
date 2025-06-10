import 'package:student_portal/features/home/data/model/post_model/reply.dart';
import 'package:student_portal/features/home/data/model/post_model/vote.dart';

import '../../../../resource/data/model/resource.dart';
import 'attachment.dart';
import 'creator.dart';

class Discussion {
  final String? id;
  final String? title;
  final String? content;
  final Creator? creator;
  final List<Attachment>? attachments;
  final String? status;
  final List<Reply>? replies;
  final List<Vote>? votes;
  final int? upVotesCount;
  final int? downVotesCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Discussion({
    this.id,
    this.title,
    this.content,
    this.creator,
    this.attachments,
    this.status,
    this.replies,
    this.votes,
    this.upVotesCount,
    this.downVotesCount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      creator: json['creator'] != null ? Creator.fromJson(json['creator']) : null,
      attachments: (json['attachments'] as List?)
          ?.map((e) => Attachment.fromJson(e))
          .toList(),
      status: json['status'],
      replies: (json['replies'] as List?)?.map((e) => Reply.fromJson(e)).toList(),
      votes: (json['votes'] as List?)?.map((e) => Vote.fromJson(e)).toList(),
      downVotesCount: json['downvotesCount'],
      upVotesCount: json['upvotesCount'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'creator': creator?.toJson(),
      'attachments': attachments?.map((e) => e.toJson()).toList(),
      'status': status,
      'replies': replies?.map((e) => e.toJson()).toList(),
      'votes': votes,
      'upvotesCount': upVotesCount,
      'downvotesCount': downVotesCount,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }

  Uploader get uploader => Uploader(
        profilePicture: creator?.profilePicture,
        name: creator?.name,
        id: creator?.id,
      );
}
