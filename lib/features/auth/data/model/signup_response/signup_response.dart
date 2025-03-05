import 'package:equatable/equatable.dart';
import '../user_model/user.dart';

class SignupResponse extends Equatable {
  final bool? success;
  final String? message;
  final User? data;

  const SignupResponse({this.success, this.message, this.data});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : User.fromJson(json['data']['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };

  @override
  List<Object?> get props => [success, message, data];
}
