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