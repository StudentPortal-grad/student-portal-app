import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../../core/utils/secure_storage.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/model/token_model/token_model.dart';
import '../../../data/repo_impl/check_email_impl.dart';
import '../../../data/repo_impl/signup_repo_impl.dart';
import '../../../data/repo_impl/update_data_impl.dart';
import '../../../data/repo_impl/verify_email_impl.dart';
import '../../../domain/usecases/check_email_uc.dart';
import '../../../domain/usecases/signup_uc.dart';
import '../../../domain/usecases/update_date_uc.dart';
import '../../../domain/usecases/verify_email_uc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupRequested>(_onSignupRequested);
    on<VerifyEmailRequested>(_onVerifyEmailRequested);
    on<ResendCodeRequested>(_onResendCodeRequested);
    on<UpdateDataRequested>(_onUpdateDataRequested);
    on<OnPageChanged>(_onPageChanged);
    on<OnPinCodeChanged>(_onPinCodeChanged);
  }

  final SignupUc signupUc =
      SignupUc(signupRepo: SignupRepoImpl(getIt.get<ApiService>()));
  final VerifyEmailUc verifyEmailUc = VerifyEmailUc(
      verifyEmailRepo: VerifyEmailRepoImpl(getIt.get<ApiService>()));
  final CheckEmailUc checkEmailUc =
      CheckEmailUc(checkEmailRepo: CheckEmailRepoImpl(getIt.get<ApiService>()));
  final UpdateDateUc updateDataUc =
      UpdateDateUc(updateDataRepo: UpdateDataImpl(getIt.get<ApiService>()));

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final PageController pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String pinCode = '';
  int index = 0;

  nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  _onPageChanged(OnPageChanged event, Emitter<SignupState> emit) async {
    index = event.index;
    emit(SignupPageChanged());
  }

  _onPinCodeChanged(OnPinCodeChanged event, Emitter<SignupState> emit) async {
    pinCode = event.pinCode;
    emit(SignupPinCodeChanged());
  }

  Future<void> _onSignupRequested(
      SignupRequested event, Emitter<SignupState> emit) async {
    if (!formKey.currentState!.validate()) return;
    emit(SignupLoading());
    var data = await signupUc.call(signupRequest: event.signupRequest);

    data.fold(
      (error) => emit(SignupFailure(error: error)),
      (response) => emit(SignupSuccess(signupResponse: response)),
    );
  }

  Future<void> _onVerifyEmailRequested(
      VerifyEmailRequested event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    var data = await verifyEmailUc.call(
      pinCode: event.pinCode,
      email: event.email,
    );

    data.fold(
      (error) => emit(EmailVerificationFailure(error: error)),
      (response) => emit(EmailVerificationSuccess()),
    );
  }

  Future<void> _onResendCodeRequested(
      ResendCodeRequested event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    var data = await checkEmailUc.call(email: event.email);

    data.fold(
      (error) => emit(ResendCodeFailure(error: error)),
      (response) => emit(ResendCodeSuccess()),
    );
  }

  Future<void> _onUpdateDataRequested(
      UpdateDataRequested event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    TokenModel? tokenModel = await SecureStorage().readSecureData();

    var data = await updateDataUc.call(
      jsonData: event.jsonData,
      tokenModel: tokenModel!,
    );

    data.fold(
      (error) => emit(UpdateDataFailure(error: error)),
      (response) => emit(UpdateDataSuccess()),
    );
  }
}
