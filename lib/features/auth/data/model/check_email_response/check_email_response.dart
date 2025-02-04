import 'package:equatable/equatable.dart';

import 'data.dart';

class CheckEmailResponse extends Equatable {
  final bool? success;
  final int? status;
  final Data? data;

  const CheckEmailResponse({this.success, this.status, this.data});

  factory CheckEmailResponse.fromJson(Map<String, dynamic> json) {
    return CheckEmailResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
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
