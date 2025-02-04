import 'package:equatable/equatable.dart';

class ForgetPasswordResponse extends Equatable {
  final int? status;
  final bool? success;
  final String? data;

  const ForgetPasswordResponse({this.status, this.success, this.data});

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      data: json['data'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'success': success,
        'data': data,
      };

  @override
  List<Object?> get props => [status, success, data];
}
