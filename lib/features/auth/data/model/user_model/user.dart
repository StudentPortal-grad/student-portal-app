import 'package:equatable/equatable.dart';
import 'package:student_portal/features/auth/data/model/user_model/picture.dart';


class User extends Equatable {
  final String? id;
  final String? fullname;
  final String? email;
  final String? contactNumber;
  final String? role;
  final String? activityLevel;
  final DateTime? dateOfBirth;
  final List<dynamic>? goals;
  final Picture? picture;
  final dynamic currWorkoutPlan;
  final dynamic currNutritionPlan;
  final dynamic currSupplementPlan;
  final List<dynamic>? savedBlogs;
  final List<dynamic>? notifications;
  final bool? emailActive;
  final bool? active;
  final String? gender;
  final num? height;
  final num? weight;
  final String? allergies;
  final String? healthIssues;

  const User({
    this.id,
    this.fullname,
    this.email,
    this.contactNumber,
    this.dateOfBirth,
    this.role,
    this.activityLevel,
    this.goals,
    this.picture,
    this.currWorkoutPlan,
    this.currNutritionPlan,
    this.currSupplementPlan,
    this.savedBlogs,
    this.notifications,
    this.emailActive,
    this.active,
    this.gender,
    this.height,
    this.weight,
    this.allergies,
    this.healthIssues,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] as String?,
        fullname: json['fullname'] as String?,
        email: json['email'] as String?,
        contactNumber: json['contactNumber'] as String?,
        dateOfBirth: json['dateOfBirth'] == null
            ? null
            : DateTime.parse(json['dateOfBirth'] as String),
        role: json['role'] as String?,
        activityLevel: json['activityLevel'] as String?,
        goals: json['goals'],
        picture: json['picture'] == null
            ? null
            : Picture.fromJson(json['picture'] as Map<String, dynamic>),
        currWorkoutPlan: json['currWorkoutPlan'] as dynamic,
        currNutritionPlan: json['currNutritionPlan'] as dynamic,
        currSupplementPlan: json['currSupplementPlan'] as dynamic,
        savedBlogs: json['savedBlogs'] as List<dynamic>?,
        notifications: json['notifications'] as List<dynamic>?,
        emailActive: json['emailActive'] as bool?,
        active: json['active'] as bool?,
        gender: json['gender'] as String?,
        height: json['height'] as num?,
        weight: json['weight'] as num?,
        healthIssues: json['healthIssues'] as String?,
        allergies: json['allergies'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'fullname': fullname,
        'email': email,
        'contactNumber': contactNumber,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'role': role,
        'goals': goals,
        'activityLevel': activityLevel,
        'picture': picture?.toJson(),
        'currWorkoutPlan': currWorkoutPlan,
        'currNutritionPlan': currNutritionPlan,
        'currSupplementPlan': currSupplementPlan,
        'savedBlogs': savedBlogs,
        'notifications': notifications,
        'emailActive': emailActive,
        'active': active,
        'gender': gender,
        'height': height,
        'weight': weight,
        'healthIssues': healthIssues,
        'allergies': allergies,
      };

  @override
  List<Object?> get props {
    return [
      id,
      fullname,
      email,
      role,
      contactNumber,
      dateOfBirth,
      activityLevel,
      goals,
      picture,
      currWorkoutPlan,
      currNutritionPlan,
      currSupplementPlan,
      savedBlogs,
      notifications,
      emailActive,
      active,
      gender,
      height,
      weight,
      healthIssues,
      allergies
    ];
  }
}
