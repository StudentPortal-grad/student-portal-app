import 'package:equatable/equatable.dart';

import '../user_model/user.dart';


class ResetPasswordResponse extends Equatable {
  final int? status;
  final bool? success;
  final User? data;

  const ResetPasswordResponse({this.status, this.success, this.data});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      data: json['data']['client'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'success': success,
        'data': data?.toJson(),
      };

  @override
  List<Object?> get props => [status, success, data];
}
