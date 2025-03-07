class Attachment {
  final String? type;
  final String? resource;
  final String? thread;

  Attachment({
    required this.type,
    required this.resource,
    this.thread,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      type: json['type'] as String,
      resource: json['resource'] as String,
      thread: json['thread'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (type != null) 'type': type,
      if (resource != null) 'resource': resource,
      if (thread != null) 'thread': thread,
    };
  }
}
