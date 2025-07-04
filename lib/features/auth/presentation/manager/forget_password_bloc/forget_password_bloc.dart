import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/features/auth/domain/usecases/forget_password_uc.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../domain/repo/auth_repo.dart';
import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgetPasswordUc forgetPasswordUc = ForgetPasswordUc(authRepository: getIt.get<AuthRepository>());

  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<ForgetPasswordRequested>(_onForgetPasswordRequested);
    on<ForgetPasswordEmailValidation>(_onForgetPasswordEmailValidation);
  }

  final TextEditingController emailController = TextEditingController();

  Future<void> _onForgetPasswordRequested(
      ForgetPasswordRequested event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetPasswordLoading());

    var data = await forgetPasswordUc.call(email: event.email);

    data.fold(
      (error) => emit(ForgetPasswordFailure(error: error)),
      (response) => emit(ForgetPasswordSuccess(message: response)),
    );
  }

  void _onForgetPasswordEmailValidation(
      ForgetPasswordEmailValidation event, Emitter<ForgetPasswordState> emit) {
    bool isValid = (AppRegex.validateEmail(event.email) == null);
    emit(ForgetPasswordEmailValidated(validEmail: isValid));
  }
}
