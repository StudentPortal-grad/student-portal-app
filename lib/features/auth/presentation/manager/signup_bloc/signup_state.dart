import 'package:equatable/equatable.dart';
import '../../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../data/model/signup_response/signup_response.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupPageChanged extends SignupState {}

class SignupPinCodeChanged extends SignupState {}

class SignupLoading extends SignupState {}

class OtpLoading extends SignupState {}

class ResendOtpLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final SignupResponse signupResponse;

  SignupSuccess({required this.signupResponse});

  @override
  List<Object?> get props => [signupResponse];
}

class SignupFailure extends SignupState {
  final Failure error;

  SignupFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class EmailVerificationSuccess extends SignupState {}

class EmailVerificationFailure extends SignupState {
  final Failure error;

  EmailVerificationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ResendCodeSuccess extends SignupState {}

class ResendCodeFailure extends SignupState {
  final Failure error;

  ResendCodeFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignupProfileImagePicked extends SignupState {}

class SignupTopicSelected extends SignupState {}

class UpdateDataSuccess extends SignupState {}

class UpdateDataFailure extends SignupState {
  final Failure error;

  UpdateDataFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class PasswordStrengthUpdated extends SignupState {
  final List<bool> strengthCriteria;

  PasswordStrengthUpdated({required this.strengthCriteria});

  @override
  List<Object?> get props => [strengthCriteria];
}

class ConfirmPasswordUpdated extends SignupState {
  final bool isMatching;

  ConfirmPasswordUpdated({required this.isMatching});

  @override
  List<Object?> get props => [isMatching];
}
