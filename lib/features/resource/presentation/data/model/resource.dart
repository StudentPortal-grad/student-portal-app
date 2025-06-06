class Resource {
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
  final List<dynamic>? comments;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Resource({
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
    uploader:
    json["uploader"] != null ? Uploader.fromJson(json["uploader"]) : null,
    interactionStats: json["interactionStats"] != null
        ? InteractionStats.fromJson(json["interactionStats"])
        : null,
    ratings: json["ratings"],
    comments: json["comments"],
    createdAt: json["createdAt"] != null
        ? DateTime.tryParse(json["createdAt"])
        : null,
    updatedAt: json["updatedAt"] != null
        ? DateTime.tryParse(json["updatedAt"])
        : null,
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
    "comments": comments,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
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
