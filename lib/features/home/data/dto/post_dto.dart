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
      formDataMap['attachments'] = await Future.wait(images!.map(
        (path) => MultipartFile.fromFile(
          path,
          filename: path.split('/').last,
          contentType: MediaType.parse('image/${path.split('.').last}'),
        ),
      ));
    }

    if (tags != null && tags!.isNotEmpty) {
      formDataMap['tags'] = (tags);
    }
    return FormData.fromMap(formDataMap);
  }
}
