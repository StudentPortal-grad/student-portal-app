import 'package:equatable/equatable.dart';

class SignupDTO extends Equatable {
  final String? email;
  final String? password;
  final String? fullName;

  const SignupDTO({
    this.email,
    this.password,
    this.fullName,
  });

  factory SignupDTO.fromJson(Map<String, dynamic> json) => SignupDTO(
        email: json['email'] as String?,
        password: json['password'] as String?,
        fullName: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': fullName,
      };

  @override
  List<Object?> get props => [email, password, fullName];
}
