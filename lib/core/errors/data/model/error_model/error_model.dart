import 'package:equatable/equatable.dart';


class Failure extends Equatable {
  final String? message;
  final bool? success;

  const Failure({
    this.message,
    this.success,
  });

  factory Failure.fromJson(Map<String, dynamic> json) => Failure(
        message: json['message'] as String?,
        success: json['success'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
      };

  @override
  List<Object?> get props => [message, success];
}
