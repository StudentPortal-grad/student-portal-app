import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class LoadingSuccess extends LoginState {
  final dynamic response;

  LoadingSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class LoadingFailure extends LoginState {
  final String error;

  LoadingFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoadingPasswordCheckerState extends LoginState {
  final bool isPasswordSecure;

  LoadingPasswordCheckerState({required this.isPasswordSecure});

  @override
  List<Object?> get props => [isPasswordSecure];
}

class LoadingEmailValidationState extends LoginState {
  final bool isEmailValid;

  LoadingEmailValidationState({required this.isEmailValid});

  @override
  List<Object?> get props => [isEmailValid];
}
