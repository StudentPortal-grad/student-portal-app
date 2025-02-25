import '../../../auth/data/model/user_model/user.dart';

class GroupModel {
  final String id;
  final String name;
  final String? urlImage;
  final String? createdBy; // admin id
  final DateTime? createdAt;
  final List<User> members;

  GroupModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    this.members = const [],
    this.urlImage,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      members: List<User>.from(json['members'] ?? []),
      urlImage: json['urlImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'createdAt': createdAt?.toIso8601String(),
      'urlImage': urlImage,
      'members': members,
    };
  }
}
