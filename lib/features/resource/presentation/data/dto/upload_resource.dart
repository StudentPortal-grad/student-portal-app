import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class ResourceDto {
  final String? title;
  final String? content;
  final String? visibility;
  final String? category;
  final List<String>? tags;
  final List<String>? attachments;

  ResourceDto({
    required this.title,
    required this.content,
    this.visibility,
    this.category,
    this.tags,
    this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': content,
      'visibility': visibility,
      'category': category,
      'tags': tags,
      'attachments': attachments,
    };
  }

  factory ResourceDto.fromJson(Map<String, dynamic> json) {
    return ResourceDto(
      title: json['title'],
      content: json['description'],
      visibility: json['visibility'],
      category: json['category'],
      tags: json['tags'],
      attachments: json['attachments'],
    );
  }

  Future<FormData> toFormData() async {
    final Map<String, dynamic> formDataMap = {};

    if (title != null) formDataMap['title'] = title;
    if (content != null) formDataMap['description'] = content;

    if (attachments != null && attachments!.isNotEmpty) {
      formDataMap['attachments'] = await Future.wait(attachments!.map(
        (path) => MultipartFile.fromFile(
          path,
          filename: path.split('/').last,
          contentType: MediaType.parse('image/${path.split('.').last}'),
        ),
      ));
    }

    if (tags != null && tags!.isNotEmpty) {
      formDataMap['tags'] = jsonEncode(tags);
    }
    if (visibility != null) formDataMap['visibility'] = visibility;
    if (category != null) formDataMap['category'] = category;
    return FormData.fromMap(formDataMap);
  }
}
