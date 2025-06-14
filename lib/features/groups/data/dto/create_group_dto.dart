import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class CreateGroupDto {
  final String name;
  final String? description;
  final List<String> usersId;
  final String? groupImage;

  CreateGroupDto({
    required this.name,
    this.description,
    this.usersId = const [],
    this.groupImage,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'usersId': usersId,
    'groupImage': groupImage,
  };

  factory CreateGroupDto.fromJson(Map<String, dynamic> json) => CreateGroupDto(
    name: json['name'],
    description: json['description'],
    usersId: List<String>.from(json['usersId']),
    groupImage: json['groupImage'],
  );

  Future<FormData> toFormData() async {
    final formData = FormData();

    formData.fields.add(MapEntry('name', name));

    if (description != null) {
      formData.fields.add(MapEntry('description', description!));
    }

    if (groupImage != null) {
      final fileName = groupImage!.split('/').last;
      final extension = fileName.split('.').last.toLowerCase();
      final contentType = MediaType('image', extension == 'jpg' ? 'jpeg' : extension);

      formData.files.add(
        MapEntry(
          'groupImage',
          await MultipartFile.fromFile(
            groupImage!,
            filename: fileName,
            contentType: contentType,
          ),
        ),
      );
    }

    for (final id in usersId) {
      formData.fields.add(MapEntry('participants', id));
    }

    return formData;
  }

}
