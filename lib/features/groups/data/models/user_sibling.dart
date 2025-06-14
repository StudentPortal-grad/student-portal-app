class UserSibling {
  final String? id;
  final String? name;
  final String? profilePicture;
  final int? level;
  final String? userName;

  const UserSibling({this.id, this.name, this.profilePicture, this.level,this.userName});

  factory UserSibling.fromJson(Map<String, dynamic> map) {
    return UserSibling(
      id: map['_id'],
      name: map['name'],
      profilePicture: map['profilePicture'],
      userName: map['userName'],
      level: map['level'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['profilePicture'] = profilePicture;
    data['level'] = level;
    data['userName'] = userName;
    return data;
  }
}