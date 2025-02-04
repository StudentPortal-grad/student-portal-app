import 'package:equatable/equatable.dart';

class Args extends Equatable {
  final String? accessToken;
  final String? refreshToken;

  const Args({this.accessToken, this.refreshToken});

  factory Args.fromJson(Map<String, dynamic> json) => Args(
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
