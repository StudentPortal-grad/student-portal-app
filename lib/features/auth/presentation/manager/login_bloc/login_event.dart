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

class LoginValidation extends LoginEvent {
  final String? email;
  final String? password;

  LoginValidation({
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
