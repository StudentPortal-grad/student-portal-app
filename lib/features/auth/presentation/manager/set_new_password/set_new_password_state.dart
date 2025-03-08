import 'package:equatable/equatable.dart';
import '../../../../../core/errors/data/model/error_model.dart';

abstract class SetNewPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetNewPasswordInitial extends SetNewPasswordState {}

class SetNewPasswordLoading extends SetNewPasswordState {}

class SetNewPasswordSuccess extends SetNewPasswordState {
  final bool success;

  SetNewPasswordSuccess({required this.success});

  @override
  List<Object?> get props => [success];
}

class SetNewPasswordFailure extends SetNewPasswordState {
  final Failure error;

  SetNewPasswordFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class SetNewPasswordConfirmed extends SetNewPasswordState {
  final bool isMatching;

  SetNewPasswordConfirmed({required this.isMatching});

  @override
  List<Object?> get props => [isMatching];
}
