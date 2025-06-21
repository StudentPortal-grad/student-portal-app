import '../../../auth/data/model/user_model/user.dart';

class UserSibling {
  final String? id;
  final String? name;
  final String? profilePicture;
  final int? level;
  final String? userName;
  final int? followersCount;
  final int? followingCount;

  const UserSibling({
    this.id,
    this.name,
    this.profilePicture,
    this.level,
    this.userName,
    this.followersCount,
    this.followingCount,
  });

  factory UserSibling.fromJson(Map<String, dynamic> map) {
    return UserSibling(
      id: map['_id'],
      name: map['name'],
      profilePicture: map['profilePicture'],
      userName: map['userName'],
      level: map['level'],
      followersCount: map['followersCount'],
      followingCount: map['followingCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['profilePicture'] = profilePicture;
    data['level'] = level;
    data['userName'] = userName;
    data['followingCount'] = followingCount;
    data['followersCount'] = followersCount;
    return data;
  }

  User toUser() => User(
        id: id,
        name: name,
        profilePicture: profilePicture,
        level: level,
        username: userName,
      );
}
