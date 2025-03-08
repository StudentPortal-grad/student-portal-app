import 'package:equatable/equatable.dart';
import '../../../../../core/errors/data/model/error_model.dart';

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
  final String message;

  ResendEmailSuccess(this.message);

  @override
  List<Object?> get props => [message];
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
