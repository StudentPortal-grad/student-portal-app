import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOtpForgetPassword extends OtpEvent {
  final String pinCode;
  final String email;

  SendOtpForgetPassword({required this.pinCode, required this.email});

  @override
  List<Object?> get props => [pinCode, email];
}

class SendOtpVerify extends OtpEvent {
  final String email;

  SendOtpVerify({required this.email});

  @override
  List<Object?> get props => [email];
}

class VerifyEmail extends OtpEvent {
  final String pinCode;
  final String email;

  VerifyEmail({required this.pinCode, required this.email});

  @override
  List<Object?> get props => [pinCode, email];
}

class ResendEmail extends OtpEvent {
  final String email;

  ResendEmail({required this.email});

  @override
  List<Object?> get props => [email];
}

class OtpCodeChanged extends OtpEvent {
  final String pinCode;

  OtpCodeChanged({required this.pinCode});

  @override
  List<Object?> get props => [pinCode];
}
