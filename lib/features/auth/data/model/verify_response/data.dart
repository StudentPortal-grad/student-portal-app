import 'package:equatable/equatable.dart';

/// todo unnecessary model
class Data extends Equatable {
  final String? accessToken;
  final String? refreshToken;
  final String? id;
  final String? email;

  const Data({this.accessToken, this.refreshToken, this.id, this.email});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
        id: json['_id'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        '_id': id,
        'email': email,
      };

  @override
  List<Object?> get props => [accessToken, refreshToken, id, email];
}
