import 'package:equatable/equatable.dart';
import '../../../data/dto/signup_request.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupRequested extends SignupEvent {
  final SignupDTO signupRequest;

  SignupRequested({required this.signupRequest});

  @override
  List<Object?> get props => [signupRequest];
}

class OnPinCodeChanged extends SignupEvent {
  final String pinCode;

  OnPinCodeChanged({required this.pinCode});
}

class OnPageChanged extends SignupEvent {
  final int index;

  OnPageChanged({required this.index});

  @override
  List<Object?> get props => [index];
}

class VerifyEmailRequested extends SignupEvent {
  final String pinCode;
  final String email;

  VerifyEmailRequested({required this.pinCode, required this.email});

  @override
  List<Object?> get props => [pinCode, email];
}

class ResendCodeRequested extends SignupEvent {
  final String email;

  ResendCodeRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class UpdateDataRequested extends SignupEvent {
  final Map<String, dynamic> jsonData;

  UpdateDataRequested({required this.jsonData});

  @override
  List<Object?> get props => [jsonData];
}

class PasswordStrengthChecked extends SignupEvent {
  final String password;

  PasswordStrengthChecked({required this.password});

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChecked extends SignupEvent {
  final String password;
  final String confirmPassword;

  ConfirmPasswordChecked(
      {required this.password, required this.confirmPassword});

  @override
  List<Object?> get props => [password, confirmPassword];
}
