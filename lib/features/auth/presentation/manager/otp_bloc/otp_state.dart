import 'package:equatable/equatable.dart';
import '../../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../data/model/forget_password_response/forget_password_response.dart';

abstract class OtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpFailure extends OtpState {
  final Failure error;

  OtpFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class SendOtpSuccess extends OtpState {}

class SendOtpFailure extends OtpState {
  final Failure error;

  SendOtpFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ResendEmailLoading extends OtpState {}

class ResendEmailSuccess extends OtpState {
  final ForgetPasswordResponse response;

  ResendEmailSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ResendEmailFailure extends OtpState {
  final Failure error;

  ResendEmailFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class OtpInputChanged extends OtpState {
  final bool otpValid;

  OtpInputChanged({required this.otpValid});
}
