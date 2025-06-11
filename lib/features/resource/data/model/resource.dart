import 'package:equatable/equatable.dart';

import '../../../home/data/model/post_model/reply.dart';

class Resource extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? fileUrl;
  final String? fileType;
  final String? mimeType;
  final String? originalFileName;
  final String? checksum;
  final int? fileSize;
  final List<String>? tags;
  final String? visibility;
  final String? category;
  final Uploader? uploader;
  final InteractionStats? interactionStats;
  final List<dynamic>? ratings;
  final List<Reply>? comments;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? currentVote;
  final int? upVotesCount;
  final int? downVotesCount;
  final int? v;

  const Resource({
    this.id,
    this.title,
    this.description,
    this.fileUrl,
    this.fileType,
    this.mimeType,
    this.originalFileName,
    this.checksum,
    this.fileSize,
    this.tags,
    this.visibility,
    this.category,
    this.uploader,
    this.interactionStats,
    this.ratings,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.upVotesCount,
    this.downVotesCount,
    this.currentVote,
    this.v,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        fileUrl: json["fileUrl"],
        fileType: json["fileType"],
        mimeType: json["mimeType"],
        originalFileName: json["originalFileName"],
        checksum: json["checksum"],
        fileSize: json["fileSize"],
        tags: json["tags"] != null ? List<String>.from(json["tags"]) : null,
        visibility: json["visibility"],
        category: json["category"],
        uploader: json["uploader"] != null
            ? Uploader.fromJson(json["uploader"])
            : null,
        interactionStats: json["interactionStats"] != null
            ? InteractionStats.fromJson(json["interactionStats"])
            : null,
        ratings: json["ratings"],
        comments:
            (json["comments"] as List?)?.map((e) => Reply.fromJson(e)).toList(),
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"])
            : null,
        upVotesCount: json["upvotesCount"],
        downVotesCount: json["downvotesCount"],
        currentVote: json["currentVote"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "fileUrl": fileUrl,
        "fileType": fileType,
        "mimeType": mimeType,
        "originalFileName": originalFileName,
        "checksum": checksum,
        "fileSize": fileSize,
        "tags": tags,
        "visibility": visibility,
        "category": category,
        "uploader": uploader?.toJson(),
        "interactionStats": interactionStats?.toJson(),
        "ratings": ratings,
        "comments": comments?.map((e) => e.toJson()).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "upVotesCount": upVotesCount,
        "downVotesCount": downVotesCount,
        "currentVote": currentVote,
        "__v": v,
      };

  Resource copyWith({
    String? id,
    String? title,
    String? description,
    String? fileUrl,
    String? fileType,
    String? mimeType,
    String? originalFileName,
    String? checksum,
    int? fileSize,
    List<String>? tags,
    String? visibility,
    String? category,
    Uploader? uploader,
    InteractionStats? interactionStats,
    List<dynamic>? ratings,
    List<Reply>? comments,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? currentVote,
    int? upVotesCount,
    int? downVotesCount,
    int? v,
  }) {
    return Resource(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      fileType: fileType ?? this.fileType,
      mimeType: mimeType ?? this.mimeType,
      originalFileName: originalFileName ?? this.originalFileName,
      checksum: checksum ?? this.checksum,
      fileSize: fileSize ?? this.fileSize,
      tags: tags ?? this.tags,
      visibility: visibility ?? this.visibility,
      category: category ?? this.category,
      uploader: uploader ?? this.uploader,
      interactionStats: interactionStats ?? this.interactionStats,
      ratings: ratings ?? this.ratings,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currentVote: currentVote ?? this.currentVote,
      upVotesCount: upVotesCount ?? this.upVotesCount,
      downVotesCount: downVotesCount ?? this.downVotesCount,
      v: v ?? this.v,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        fileUrl,
        fileType,
        mimeType,
        originalFileName,
        checksum,
        fileSize,
        tags,
        visibility,
        category,
        uploader,
        interactionStats,
        ratings,
        comments,
        createdAt,
        updatedAt,
        upVotesCount,
        downVotesCount,
        currentVote,
        v,
      ];
}

class InteractionStats {
  final int? downloads;
  final int? views;

  InteractionStats({
    this.downloads,
    this.views,
  });

  factory InteractionStats.fromJson(Map<String, dynamic> json) =>
      InteractionStats(
        downloads: json["downloads"],
        views: json["views"],
      );

  Map<String, dynamic> toJson() => {
        "downloads": downloads,
        "views": views,
      };
}

class Uploader {
  final String? id;
  final String? name;
  final String? profilePicture;

  Uploader({
    this.id,
    this.name,
    this.profilePicture,
  });

  factory Uploader.fromJson(Map<String, dynamic> json) => Uploader(
        id: json["_id"],
        name: json["name"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profilePicture": profilePicture,
      };
}
