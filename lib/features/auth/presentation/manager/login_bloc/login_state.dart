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

class LoginValidationState extends LoginState {
  final bool? isEmailValid;
  final bool? isPasswordSecure;

  LoginValidationState({this.isEmailValid, this.isPasswordSecure});

  @override
  List<Object?> get props => [isEmailValid, isPasswordSecure];
}
