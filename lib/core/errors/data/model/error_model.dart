import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? message;
  final String? details;
  final bool? success;
  final String? code;

  const Failure({
    this.message,
    this.success,
    this.details,
    this.code,
  });

  factory Failure.fromJson(Map<String, dynamic> json) => Failure(
        message: json['message'] as String?,
        success: json['success'] as bool?,
        details: json['details'] as String?,
        code: json['error']['code'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'details': details,
        'code': code,
      };

  @override
  List<Object?> get props => [message, success];
}
