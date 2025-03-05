import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../data/dto/login_request.dart';
import '../../../domain/usecases/login_uc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUc loginUc;

  LoginBloc({required this.loginUc}) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LoginValidation>(_onLoginValidation);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    emit(LogInLoading());

    var data = await loginUc.call(
      loginRequest: LoginRequest(
        email: event.email.trim(),
        password: event.password,
      ),
    );
    data.fold(
      (error) => emit(LogInFailure(error: error.name ?? 'Unknown error')),
      (response) => emit(LogInSuccess(success: response)),
    );
  }

  void _onLoginValidation(
      LoginValidation event, Emitter<LoginState> emit) {
    List<bool> strengthCriteria =
        AppRegex.checkPasswordStrength(passwordController.text);
    bool isSecure = strengthCriteria.every((criteria) => criteria);
    bool isValid = (AppRegex.validateEmail(emailController.text) == null);
    emit(LoginValidationState(
        isPasswordSecure: isSecure, isEmailValid: isValid));
  }
}
