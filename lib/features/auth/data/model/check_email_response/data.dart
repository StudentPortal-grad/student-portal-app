import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final String? id;
  final String? fullname;
  final String? email;
  final bool? active;
  final bool? emailActive;
  final List<dynamic>? notifications;
  final int? v;
  final String? verifyEmailOtpToken;
  final DateTime? verifyEmailExpires;

  const Data({
    this.id,
    this.fullname,
    this.email,
    this.active,
    this.emailActive,
    this.notifications,
    this.v,
    this.verifyEmailOtpToken,
    this.verifyEmailExpires,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['_id'] as String?,
        fullname: json['fullname'] as String?,
        email: json['email'] as String?,
        active: json['active'] as bool?,
        emailActive: json['emailActive'] as bool?,
        notifications: json['notifications'] as List<dynamic>?,
        v: json['__v'] as int?,
        verifyEmailOtpToken: json['verifyEmailOTPToken'] as String?,
        verifyEmailExpires: json['verifyEmailExpires'] == null
            ? null
            : DateTime.parse(json['verifyEmailExpires'] as String),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'fullname': fullname,
        'email': email,
        'active': active,
        'emailActive': emailActive,
        'notifications': notifications,
        '__v': v,
        'verifyEmailOTPToken': verifyEmailOtpToken,
        'verifyEmailExpires': verifyEmailExpires?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      fullname,
      email,
      active,
      emailActive,
      notifications,
      v,
      verifyEmailOtpToken,
      verifyEmailExpires,
    ];
  }
}
