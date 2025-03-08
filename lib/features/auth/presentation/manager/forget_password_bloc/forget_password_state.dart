import 'package:equatable/equatable.dart';
import '../../../../../core/errors/data/model/error_model.dart';

abstract class ForgetPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;

  ForgetPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
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
