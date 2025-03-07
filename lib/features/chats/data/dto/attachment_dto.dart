class AttachmentDto {
  final String type;
  final String resource;
  final String? threadId;

  AttachmentDto({
    required this.type,
    required this.resource,
    this.threadId,
  });

  factory AttachmentDto.fromJson(Map<String, dynamic> json) {
    return AttachmentDto(
      type: json['type'] as String,
      resource: json['resource'] as String,
      threadId: json['thread'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'resource': resource,
      'thread': threadId,
    };
  }
}