class TokenModel {
  final String? id;
  final String? accessToken;
  final String? refreshToken;

  TokenModel({
    this.id,
    this.accessToken,
    this.refreshToken,
  });

  /// Creates a `TokenModel` instance from a JSON map.
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      id: json['id'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  /// Converts a `TokenModel` instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  /// Helper method to check if the token data is valid.
  bool get isValid {
    return id != null && accessToken != null && refreshToken != null;
  }
}
