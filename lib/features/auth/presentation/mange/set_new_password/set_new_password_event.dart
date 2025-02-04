import 'package:equatable/equatable.dart';

abstract class SetNewPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetNewPasswordRequested extends SetNewPasswordEvent {
  final String password;

  SetNewPasswordRequested({required this.password});

  @override
  List<Object?> get props => [password];
}

class PasswordStrengthChecked extends SetNewPasswordEvent {
  final String password;

  PasswordStrengthChecked({required this.password});

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChecked extends SetNewPasswordEvent {
  final String password;
  final String confirmPassword;

  ConfirmPasswordChecked({required this.password, required this.confirmPassword});

  @override
  List<Object?> get props => [password, confirmPassword];
}
