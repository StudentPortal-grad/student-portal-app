import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../auth/data/model/user_model/profile.dart';

class UpdateProfileDto {
  // personal info
  final String? profilePicture;
  final String? gender;
  final String? userName;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? name;

  // Profile
  final Profile? profile;

  // academic info
  final String? university;
  final String? college;
  final String? position;
  final num? gpa;
  final num? level;

  UpdateProfileDto({
    this.name,
    this.profilePicture,
    this.gender,
    this.userName,
    this.phoneNumber,
    this.dateOfBirth,
    this.university,
    this.college,
    this.position,
    this.gpa,
    this.profile,
    this.level,
  });

  toJson() => {
        'name': name,
        'profilePicture': profilePicture,
        'gender': gender,
        'userName': userName,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'university': university,
        'college': college,
        'position': position,
        'gpa': gpa,
        'level': level,
        'profile': profile?.toJson(),
      };

  // Convert to FormData for Dio
  Future<FormData> toFormData() async {
    final Map<String, dynamic> formDataMap = {};
    if (name != null) formDataMap['name'] = name;
    if (profilePicture != null) {
      formDataMap['profilePicture'] = await MultipartFile.fromFile(
        profilePicture!,
        filename: profilePicture!.split('/').last,
        contentType: MediaType.parse(
          'image/${profilePicture!.split('.').last}',
        ),
      );
    }
    if (gender != null) formDataMap['gender'] = gender;
    if (userName != null) formDataMap['userName'] = userName;
    if (phoneNumber != null) formDataMap['phoneNumber'] = phoneNumber;
    if (dateOfBirth != null) formDataMap['dateOfBirth'] = dateOfBirth;
    if (university != null) formDataMap['university'] = university;
    if (college != null) formDataMap['college'] = college;
    if (position != null) formDataMap['role'] = position;
    if (gpa != null) formDataMap['gpa'] = gpa.toString();
    if (level != null) formDataMap['level'] = level.toString();
    formDataMap['profile[bio]'] = profile?.bio == null || profile!.bio!.isEmpty
        ? "Hey there! I'm using StudyPortal!"
        : profile!.bio;
    // Handle `profile[interests][]` as multiple form fields
    if (profile?.interests != null && profile!.interests!.isNotEmpty) {
      for (var interest in profile!.interests!) {
        formDataMap.putIfAbsent('profile[interests][]', () => []).add(interest);
      }
    }
    return FormData.fromMap(formDataMap);
  }
}
