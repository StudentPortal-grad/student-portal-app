import 'package:equatable/equatable.dart';
import '../../../data/model/login_response/login_response.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LogInLoading extends LoginState {}

class LogInSuccess extends LoginState {
  final LoginResponse loginResponse;

  LogInSuccess({required this.loginResponse});

  @override
  List<Object?> get props => [loginResponse];
}

class LogInFailure extends LoginState {
  final String error;

  LogInFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoginValidationState extends LoginState {
  final bool? isEmailValid;
  final bool? isPasswordSecure;

  LoginValidationState({this.isEmailValid, this.isPasswordSecure});

  @override
  List<Object?> get props => [isEmailValid, isPasswordSecure];
}
