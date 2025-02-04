import 'package:equatable/equatable.dart';

import 'data.dart';

class VerifyResponse extends Equatable {
  final bool? success;
  final int? status;
  final Data? data;

  const VerifyResponse({this.success, this.status, this.data});

  factory VerifyResponse.fromJson(Map<String, dynamic> json) {
    return VerifyResponse(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      // data: json['data'] == null
      //     ? null
      //     : Data.fromJson(json['data'] as Map<String, dynamic>),
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
