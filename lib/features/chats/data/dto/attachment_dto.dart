import 'dart:io';

import 'package:dio/dio.dart';

class AttachmentDto {
  final String conversationId;
  final List<String> attachments;
  final String? content;

  AttachmentDto({
    required this.conversationId,
    this.attachments = const [],
    this.content,
  });

  Map<String, dynamic> toJson() => {
        'conversationId': conversationId,
        'attachments': attachments.map((e) => e).toList(),
        'content': content,
      };

  factory AttachmentDto.fromJson(Map<String, dynamic> json) => AttachmentDto(
        conversationId: json['conversationId'],
        attachments: List<String>.from(json['attachments']),
        content: json['content'],
      );

  // formData
  Future<FormData> toFormData() async {
    final formData = FormData();
    formData.fields.add(MapEntry('conversationId', conversationId));
    if (content != null) {
      formData.fields.add(MapEntry('content', content!));
    }
    for (final path in attachments) {
      final file = File(path);
      final fileName = path.split('/').last;
      formData.files.add(
        MapEntry(
          'attachments',
          await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        ),
      );
    }
    return formData;
  }
}
