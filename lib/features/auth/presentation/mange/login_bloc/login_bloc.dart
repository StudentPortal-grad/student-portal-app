import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/core/functions/validation.dart';
import '../../../data/dto/login_request/login_request.dart';
import '../../../domain/usecases/login_uc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUc loginUc;

  LoginBloc({required this.loginUc}) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<PasswordStrengthChecked>(_onPasswordStrengthChecked);
    on<EmailValidationChecked>(_onEmailValidationChecked);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoadingState());

    var data = await loginUc.call(
      loginRequest: LoginRequest(
        email: event.email.trim(),
        password: event.password,
      ),
    );

    data.fold(
      (error) => emit(LoadingFailure(error: error.name ?? 'Unknown error')),
      (response) => emit(LoadingSuccess(response: response)),
    );
  }

  void _onPasswordStrengthChecked(
      PasswordStrengthChecked event, Emitter<LoginState> emit) {
    List<bool> strengthCriteria =
        Validation.checkPasswordStrength(event.password);
    bool isSecure = strengthCriteria.every((criteria) => criteria);
    emit(LoadingPasswordCheckerState(isPasswordSecure: isSecure));
  }

  void _onEmailValidationChecked(
      EmailValidationChecked event, Emitter<LoginState> emit) {
    bool isValid = (Validation.validateEmail(event.email) == null);
    emit(LoadingEmailValidationState(isEmailValid: isValid));
  }
}
