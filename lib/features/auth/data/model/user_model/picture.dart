import 'package:equatable/equatable.dart';

class Picture extends Equatable {
  final String? publicId;
  final String? format;
  final String? resourceType;
  final String? type;
  final String? url;
  final String? secureUrl;
  final String? folder;

  const Picture({
    this.publicId,
    this.format,
    this.resourceType,
    this.type,
    this.url,
    this.secureUrl,
    this.folder,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        publicId: json['public_id'] as String?,
        format: json['format'] as String?,
        resourceType: json['resource_type'] as String?,
        type: json['type'] as String?,
        url: json['url'] as String?,
        secureUrl: json['secure_url'] as String?,
        folder: json['folder'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'public_id': publicId,
        'format': format,
        'resource_type': resourceType,
        'type': type,
        'url': url,
        'secure_url': secureUrl,
        'folder': folder,
      };

  @override
  List<Object?> get props {
    return [
      publicId,
      format,
      resourceType,
      type,
      url,
      secureUrl,
      folder,
    ];
  }
}
