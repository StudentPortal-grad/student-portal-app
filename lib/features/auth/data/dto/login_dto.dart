import 'package:equatable/equatable.dart';

class LoginDTO extends Equatable {
  final String? email;
  final String? password;

  const LoginDTO({required this.email, required this.password});

  factory LoginDTO.fromJson(Map<String, dynamic> json) => LoginDTO(
        email: json['email'] as String?,
        password: json['password'] as String?,
      );

  Map<String, dynamic> toJson() => {"email": email, "password": password};

  @override
  List<Object?> get props => [email, password];
}
