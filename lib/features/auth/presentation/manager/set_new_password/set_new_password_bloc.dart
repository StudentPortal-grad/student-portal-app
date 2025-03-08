import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/core/utils/app_router.dart';
import '../../../../../core/errors/data/model/error_model.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../../core/utils/secure_storage.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/dto/set_new_password_dto.dart';
import '../../../data/repo_impl/reset_password_impl.dart';
import '../../../domain/usecases/reset_password_uc.dart';
import 'set_new_password_event.dart';
import 'set_new_password_state.dart';

class SetNewPasswordBloc
    extends Bloc<SetNewPasswordEvent, SetNewPasswordState> {
  final ResetPasswordUc resetPasswordUc = ResetPasswordUc(
      resetPasswordRepo: ResetPasswordImpl(getIt.get<ApiService>()));

  SetNewPasswordBloc() : super(SetNewPasswordInitial()) {
    on<SetNewPasswordRequested>(_onSetNewPasswordRequested);
    on<ConfirmPasswordChecked>(_onConfirmPasswordChecked);
  }

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> _onSetNewPasswordRequested(
      SetNewPasswordRequested event, Emitter<SetNewPasswordState> emit) async {
    emit(SetNewPasswordLoading());

      String? resetToken = await SecureStorage().readResetTokenData();
      if (resetToken == null) {
        emit(SetNewPasswordFailure(error: const Failure(message: "Token not found")));
        AppRouter.clearAndNavigate(AppRouter.loginView);
        return;
      }

      var data = await resetPasswordUc.call(
          setNewPasswordDto: SetNewPasswordDto(
        password: event.password,
        token: resetToken,
      ));

      data.fold(
        (error) => emit(SetNewPasswordFailure(error: error)),
        (response) => emit(SetNewPasswordSuccess(success: response)),
      );
  }

  void _onConfirmPasswordChecked(
      ConfirmPasswordChecked event, Emitter<SetNewPasswordState> emit) {
    bool isMatching = event.password == event.confirmPassword &&
        AppRegex.checkPasswordStrength(event.password)
            .every((criterion) => criterion);
    emit(SetNewPasswordConfirmed(isMatching: isMatching));
  }
}
