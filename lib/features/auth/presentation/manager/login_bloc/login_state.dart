import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LogInLoading extends LoginState {}

class LogInSuccess extends LoginState {
  final bool success;

  LogInSuccess({required this.success});

  @override
  List<Object?> get props => [success];
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
