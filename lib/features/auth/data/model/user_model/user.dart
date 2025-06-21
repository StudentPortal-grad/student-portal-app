import 'package:student_portal/features/resource/domain/entities/resource_entity.dart';

import '../../../../../core/utils/assets_app.dart';
import '../../../../groups/data/models/user_sibling.dart';
import '../../../../home/domain/entities/post_entity.dart';
import 'profile.dart';
import 'address.dart';
import 'friend.dart';
import 'user_role.dart';

class User {
  final String? id;
  final String? name;
  final String? username;
  final String? gender;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? university;
  final String? college;
  final String? email;
  final String? role;
  final String? profilePicture;
  final Profile? profile;
  final List<Address>? addresses;
  final List<Friend>? friends;
  final int? level;
  final double? gpa;
  final String? universityEmail;
  final bool universityEmailVerified;
  final String? tempEmail;
  final bool emailVerified;
  final List<UserRole>? roles;
  final String? status;
  final bool? isGraduated;
  final int? graduationYear;
  final bool? isFollowed;
  final bool? isBlocked;
  final List<UserSibling> follower;
  final List<UserSibling> following;
  final List<PostEntity> posts;
  final List<ResourceEntity> resources;

  User({
    this.id,
    this.name,
    this.username,
    this.gender,
    this.phoneNumber,
    this.dateOfBirth,
    this.university,
    this.college,
    this.email,
    this.role,
    this.profilePicture,
    this.profile,
    this.addresses,
    this.friends,
    this.level,
    this.gpa,
    this.universityEmail,
    this.universityEmailVerified = false,
    this.tempEmail,
    this.emailVerified = false,
    this.roles,
    this.status,
    this.isGraduated = false,
    this.graduationYear,
    this.isBlocked,
    this.isFollowed,
    this.following = const [],
    this.follower = const [],
    this.posts = const [],
    this.resources = const [],
  });

  /// Convert a `User` object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'university': university,
      'college': college,
      'email': email,
      'role': role,
      'profilePicture': profilePicture,
      'profile': profile?.toJson(),
      'addresses': addresses?.map((a) => a.toJson()).toList(),
      'friends': friends?.map((f) => f.toJson()).toList(),
      'level': level,
      'gpa': gpa,
      'universityEmail': universityEmail,
      'universityEmailVerified': universityEmailVerified,
      'tempEmail': tempEmail,
      'emailVerified': emailVerified,
      'roles': roles?.map((r) => r.toJson()).toList(),
      'status': status,
      'isGraduated': isGraduated,
      'graduationYear': graduationYear,
      'isFollowed' : isFollowed,
      'isBlocked': isBlocked,
      'follower': follower,
      'following': following,
      'posts': posts,
      'resources': resources,
    };
  }

  /// Convert a JSON map into a `User` object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      username: json['username'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      university: json['university'],
      college: json['college'],
      email: json['email'],
      role: json['role'],
      profilePicture: json['profilePicture'] ?? AssetsApp.userPlaceHolder,
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      addresses: json['addresses'] != null ? (json['addresses'] as List).map((a) => Address.fromJson(a)).toList() : null,
      friends: json['friends'] != null ? (json['friends'] as List).map((f) => Friend.fromJson(f)).toList() : null,
      level: json['level'],
      gpa: (json['gpa'] as num?)?.toDouble(),
      universityEmail: json['universityEmail'],
      universityEmailVerified: json['universityEmailVerified'] ?? false,
      tempEmail: json['tempEmail'],
      emailVerified: json['emailVerified'] ?? false,
      roles: json['roles'] != null ? (json['roles'] as List).map((r) => UserRole.fromJson(r)).toList() : null,
      status: json['status'],
      isGraduated: json['isGraduated'] ?? false,
      graduationYear: json['graduationYear'],
      isFollowed: json['isFollowed'],
      isBlocked: json['isBlocked'],
      follower: json['followers'] != null ? (json['followers'] as List).whereType<Map<String, dynamic>>().map((r) => UserSibling.fromJson(r)).toList() : [],
      following: json['following'] != null ? (json['following'] as List).whereType<Map<String, dynamic>>().map((r) => UserSibling.fromJson(r)).toList() : [],
      posts: json['posts'] != null ? (json['posts'] as List).map((r) => PostEntity.fromJson(r)).toList() : [],
      resources: json ['resources'] != null ? (json['resources'] as List).map((r) => ResourceEntity.fromJson(r)).toList() : []
    );
  }

  /// Create a `User` object from raw data
  factory User.fromData({
    String? id,
    String? name,
    String? username,
    String? gender,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? university,
    String? college,
    required String email,
    String? role,
    Profile? profile,
    List<Address>? addresses,
    List<Friend>? friends,
    int? level,
    double? gpa,
    String? universityEmail,
    bool universityEmailVerified = false,
    String? tempEmail,
    bool emailVerified = false,
    List<UserRole>? roles,
    required String status,
    bool isGraduated = false,
    int? graduationYear,
    bool? isFollowed,
    bool? isBlocked,
    String? profilePicture,
    List<UserSibling> followers = const [],
    List<UserSibling> following =  const [],
  }) {
    return User(
      id: id,
      name: name,
      username: username,
      gender: gender,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      university: university,
      college: college,
      email: email,
      role: role,
      profile: profile,
      addresses: addresses,
      friends: friends,
      level: level,
      gpa: gpa,
      universityEmail: universityEmail,
      universityEmailVerified: universityEmailVerified,
      tempEmail: tempEmail,
      emailVerified: emailVerified,
      roles: roles,
      status: status,
      isGraduated: isGraduated,
      graduationYear: graduationYear,
      isFollowed: isFollowed,
      isBlocked: isBlocked,
      profilePicture: profilePicture,
      follower: followers,
      following: following
    );
  }
}
