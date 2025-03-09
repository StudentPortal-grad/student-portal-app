part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

class Authenticated extends AuthState {}

class LoggingOut extends AuthState {}

class Unauthenticated extends AuthState {
  final String? message;

  Unauthenticated({this.message});
}

class LoggingOutFailed extends AuthState {
  final String? message;

  LoggingOutFailed({this.message});
}
