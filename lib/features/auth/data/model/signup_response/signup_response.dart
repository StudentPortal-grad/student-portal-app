import 'package:equatable/equatable.dart';
import '../user_model/user.dart';

class SignupResponse extends Equatable {
  final bool? success;
  final int? status;
  final User? data;

  const SignupResponse({this.success, this.status, this.data});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'data': data?.toJson(),
      };

  @override
  List<Object?> get props => [success, status, data];
}
