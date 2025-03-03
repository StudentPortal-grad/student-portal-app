import 'package:equatable/equatable.dart';
import '../../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../data/model/reset_password_response/reset_password_response.dart';

abstract class SetNewPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetNewPasswordInitial extends SetNewPasswordState {}

class SetNewPasswordLoading extends SetNewPasswordState {}

class SetNewPasswordSuccess extends SetNewPasswordState {
  final ResetPasswordResponse response;

  SetNewPasswordSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class SetNewPasswordFailure extends SetNewPasswordState {
  final Failure error;

  SetNewPasswordFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class SetNewPasswordStrengthChecked extends SetNewPasswordState {
  final List<bool> strengthCriteria;

  SetNewPasswordStrengthChecked({required this.strengthCriteria});

  @override
  List<Object?> get props => [strengthCriteria];
}

class SetNewPasswordConfirmed extends SetNewPasswordState {
  final bool isMatching;

  SetNewPasswordConfirmed({required this.isMatching});

  @override
  List<Object?> get props => [isMatching];
}
