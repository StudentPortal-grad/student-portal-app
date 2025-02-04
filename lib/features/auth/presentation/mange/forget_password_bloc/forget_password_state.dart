import 'package:equatable/equatable.dart';
import '../../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../data/model/forget_password_response/forget_password_response.dart';

abstract class ForgetPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final ForgetPasswordResponse response;

  ForgetPasswordSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class ForgetPasswordFailure extends ForgetPasswordState {
  final Failure error;

  ForgetPasswordFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ForgetPasswordEmailValidated extends ForgetPasswordState {
  final bool validEmail;

  ForgetPasswordEmailValidated({required this.validEmail});

  @override
  List<Object?> get props => [validEmail];
}
