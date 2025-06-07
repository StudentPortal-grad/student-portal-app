import '../../../../resource/data/model/resource.dart';

class Discussion {
  final String? id;
  final String? title;
  final String? content;
  final Creator? creator;
  final List<Attachment>? attachments;
  final String? status;
  final List<dynamic>? replies;
  final List<dynamic>? votes;
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
      replies: json['replies'],
      votes: json['votes'],
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
      'replies': replies,
      'votes': votes,
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

class Creator {
  final String? id;
  final String? name;
  final String? profilePicture;

  Creator({
    this.id,
    this.name,
    this.profilePicture,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['_id'],
      name: json['name'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'profilePicture': profilePicture,
    };
  }
}

class Attachment {
  final String? type;
  final String? resource;
  final String? mimeType;
  final String? originalFileName;
  final int? fileSize;
  final String? checksum;

  Attachment({
    this.type,
    this.resource,
    this.mimeType,
    this.originalFileName,
    this.fileSize,
    this.checksum,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      type: json['type'],
      resource: json['resource'],
      mimeType: json['mimeType'],
      originalFileName: json['originalFileName'],
      fileSize: json['fileSize'],
      checksum: json['checksum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'resource': resource,
      'mimeType': mimeType,
      'originalFileName': originalFileName,
      'fileSize': fileSize,
      'checksum': checksum,
    };
  }
}
