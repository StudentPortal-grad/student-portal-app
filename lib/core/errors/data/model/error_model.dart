import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? message;
  final String? details;
  final bool? success;

  const Failure({
    this.message,
    this.success,
    this.details,
  });

  factory Failure.fromJson(Map<String, dynamic> json) => Failure(
        message: json['message'] as String?,
        success: json['success'] as bool?,
        details: json['details'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'details': details,
      };

  @override
  List<Object?> get props => [message, success];
}
