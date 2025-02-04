import 'package:equatable/equatable.dart';

class SignupRequest extends Equatable {
  final String? email;
  final String? password;
  final String? fullName;

  const SignupRequest({
    required this.email,
    required this.password,
    required this.fullName,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) => SignupRequest(
        email: json['email'] as String?,
        password: json['password'] as String?,
        fullName: json['fullname'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'fullname': fullName,
      };

  @override
  List<Object?> get props => [email, password, fullName];
}
