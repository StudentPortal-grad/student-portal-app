import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class PostDto {
  final String? title;
  final String? content;
  final List<String>? images; // file paths
  final List<String>? tags;

  PostDto({
    this.content,
    this.images,
    this.tags,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'attachments': images,
      'tags': tags,
    };
  }

  factory PostDto.fromJson(Map<String, dynamic> data) {
    return PostDto(
      title: data['title'] as String?,
      content: data['content'] as String?,
      images: (data['attachments'] as List?)?.map((e) => e.toString()).toList(),
      tags: (data['tags'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Future<FormData> toFormData() async {
    final Map<String, dynamic> formDataMap = {};

    if (title != null) formDataMap['title'] = title;
    if (content != null) formDataMap['content'] = content;

    if (images != null && images!.isNotEmpty) {
      for (var imagePath in images!) {
        formDataMap.putIfAbsent('attachments', () => []).add(
          await MultipartFile.fromFile(
            imagePath,
            filename: imagePath.split('/').last,
            contentType: MediaType.parse('image/${imagePath.split('.').last}'),
          ),
        );
      }
    }

    if (tags != null && tags!.isNotEmpty) {
      for (var tag in tags!) {
        formDataMap.putIfAbsent('tags[]', () => []).add(tag);
      }
    }
    return FormData.fromMap(formDataMap);
  }
}