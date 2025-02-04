import 'package:equatable/equatable.dart';

import '../user_model/user.dart';

class UpdateResponse extends Equatable {
  final int? status;
  final bool? success;
  final User? data;
  final dynamic error;

  const UpdateResponse({this.status, this.success, this.data, this.error});

  factory UpdateResponse.fromJson(Map<String, dynamic> json) {
    return UpdateResponse(
      status: json['status'] as int?,
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'success': success,
        'data': data?.toJson(),
        'error': error,
      };

  @override
  List<Object?> get props => [status, success, data, error];
}
