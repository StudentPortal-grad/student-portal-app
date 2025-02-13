import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../../core/utils/secure_storage.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/repo_impl/reset_password_impl.dart';
import '../../../domain/usecases/reset_password_uc.dart';
import 'set_new_password_event.dart';
import 'set_new_password_state.dart';

class SetNewPasswordBloc extends Bloc<SetNewPasswordEvent, SetNewPasswordState> {

  final ResetPasswordUc resetPasswordUc = ResetPasswordUc(resetPasswordRepo: ResetPasswordImpl(getIt.get<ApiService>()));

  SetNewPasswordBloc() : super(SetNewPasswordInitial()) {
    on<SetNewPasswordRequested>(_onSetNewPasswordRequested);
    on<PasswordStrengthChecked>(_onPasswordStrengthChecked);
    on<ConfirmPasswordChecked>(_onConfirmPasswordChecked);
  }

  Future<void> _onSetNewPasswordRequested(
      SetNewPasswordRequested event, Emitter<SetNewPasswordState> emit) async {
    emit(SetNewPasswordLoading());

    try {
      String? resetToken = await SecureStorage().readResetTokenData();
      if (resetToken == null) {
        emit(SetNewPasswordFailure(error: const Failure(error: "Token not found")));
        return;
      }

      var data = await resetPasswordUc.call(
        password: event.password,
        resetToken: resetToken,
      );

      data.fold(
            (error) => emit(SetNewPasswordFailure(error: error)),
            (response) => emit(SetNewPasswordSuccess(response: response)),
      );
    } catch (e) {
      emit(SetNewPasswordFailure(error: Failure(error: e.toString())));
    }
  }

  void _onPasswordStrengthChecked(
      PasswordStrengthChecked event, Emitter<SetNewPasswordState> emit) {
    List<bool> strengthCriteria = AppRegex.checkPasswordStrength(event.password);
    emit(SetNewPasswordStrengthChecked(strengthCriteria: strengthCriteria));
  }

  void _onConfirmPasswordChecked(
      ConfirmPasswordChecked event, Emitter<SetNewPasswordState> emit) {
    bool isMatching = event.password == event.confirmPassword &&
        AppRegex.checkPasswordStrength(event.password).every((criterion) => criterion);
    emit(SetNewPasswordConfirmed(isMatching: isMatching));
  }
}
