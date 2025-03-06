class Profile {
  final String? bio;
  final List<String>? interests;

  Profile({this.bio, this.interests});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      bio: json['bio'],
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bio': bio,
      'interests': interests,
    };
  }
}
