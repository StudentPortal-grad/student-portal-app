class Attachment {
  final String? type;
  final String? url;
  final String? fileName;
  final int? fileSize;
  final String? mimeType;

  Attachment({
    this.type,
    this.url,
    this.fileName,
    this.fileSize,
    this.mimeType,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      type: json['type'] as String?,
      url: json['url'] as String?,
      fileName: json['fileName'] as String?,
      fileSize: json['fileSize'] as int?,
      mimeType: json['mimeType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (type != null) 'type': type,
      if (url != null) 'url': url,
      if (fileName != null) 'fileName': fileName,
      if (fileSize != null) 'fileSize': fileSize,
      if (mimeType != null) 'mimeType': mimeType,
    };
  }
}
