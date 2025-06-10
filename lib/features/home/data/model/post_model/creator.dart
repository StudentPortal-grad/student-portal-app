import '../../../../resource/data/model/resource.dart';

class Creator {
  final String? id;
  final String? name;
  final String? profilePicture;

  Creator({
    this.id,
    this.name,
    this.profilePicture,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['_id'],
      name: json['name'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'profilePicture': profilePicture,
    };
  }

  Uploader get uploader => Uploader(
        profilePicture: profilePicture,
        name: name,
        id: id,
      );
}
