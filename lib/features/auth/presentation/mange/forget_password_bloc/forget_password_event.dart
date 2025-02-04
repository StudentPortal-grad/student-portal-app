import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordRequested extends ForgetPasswordEvent {
  final String email;

  ForgetPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class ForgetPasswordEmailValidation extends ForgetPasswordEvent {
  final String email;

  ForgetPasswordEmailValidation({required this.email});

  @override
  List<Object?> get props => [email];
}
