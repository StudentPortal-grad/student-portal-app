import '../../../../../core/utils/assets_app.dart';
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
  final String profilePicture;
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
    this.profilePicture = AssetsApp.profileImage,
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
  });

  /// Convert a `User` object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
    };
  }

  /// Convert a JSON map into a `User` object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      university: json['university'],
      college: json['college'],
      email: json['email'],
      role: json['role'],
      profilePicture: json['profilePicture'] ?? AssetsApp.profileImage,
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
    );
  }
}
