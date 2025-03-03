import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class PasswordStrengthChecked extends LoginEvent {
  final String password;

  PasswordStrengthChecked({required this.password});

  @override
  List<Object?> get props => [password];
}

class EmailValidationChecked extends LoginEvent {
  final String email;

  EmailValidationChecked({required this.email});

  @override
  List<Object?> get props => [email];
}
