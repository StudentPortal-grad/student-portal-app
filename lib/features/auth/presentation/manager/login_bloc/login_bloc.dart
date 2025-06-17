import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/dto/login_dto.dart';
import '../../../domain/repo/auth_repo.dart';
import '../../../domain/usecases/login_uc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LoginValidation>(_onLoginValidation);
  }

  final LoginUc loginUc = LoginUc(authRepository: getIt.get<AuthRepository>());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    emit(LogInLoading());

    var data = await loginUc.call(
      loginRequest: LoginDTO(
        email: event.email.trim(),
        password: event.password,
      ),
    );
    data.fold(
      (error) {
        print("failure ${error.toJson()}");
        emit(LogInFailure(error: error.message ?? 'Unknown error',code: error.code));
      },
      (response) => emit(LogInSuccess(success: response)),
    );
  }

  void _onLoginValidation(LoginValidation event, Emitter<LoginState> emit) {
    List<bool> strengthCriteria =
        AppRegex.checkPasswordStrength(passwordController.text);
    bool isSecure = strengthCriteria.every((criteria) => criteria);
    bool isValid = (AppRegex.validateEmail(emailController.text) == null);
    if (state is! LogInLoading) {
      emit(LoginValidationState(isPasswordSecure: isSecure, isEmailValid: isValid));
    }
  }
}
