import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/features/auth/data/dto/complete_dto.dart';
import '../../../../../core/helpers/file_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/dto/signup_otp_dto.dart';
import '../../../data/model/user_model/profile.dart';
import '../../../domain/repo/auth_repo.dart';
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
    on<OnProfileImagePicked>(_onPickProfileImage);
  }

  final SignupUc signupUc = SignupUc(authRepository: getIt.get<AuthRepository>());
  final VerifyEmailUc verifyEmailUc = VerifyEmailUc(authRepository: getIt.get<AuthRepository>());
  final ResendValidationUC resendValidationUC = ResendValidationUC(authRepository: getIt.get<AuthRepository>());
  final UpdateDateUc updateDataUc = UpdateDateUc(authRepository: getIt.get<AuthRepository>());

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String pinCode = '';

  // Page Controller
  final PageController pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> academicFormKey = GlobalKey<FormState>();
  int index = 0;

  // Profile Controllers
  final TextEditingController userNameController =
      TextEditingController(text: UserRepository.user?.username ?? '');
  final TextEditingController phoneController = TextEditingController();
  PhoneNumber? phoneNumber;
  final TextEditingController dateOfBirthController = TextEditingController();
  String? dateOfBirth;
  String? gender;
  String? profileImage;

  // academic Controllers
  final TextEditingController universityController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  String? position;

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
    emit(OtpLoading());
    var data = await verifyEmailUc.call(
      SignupOtpDto(pinCode: pinCode, email: event.email),
    );

    data.fold(
      (error) => emit(EmailVerificationFailure(error: error)),
      (response) => emit(EmailVerificationSuccess()),
    );
  }

  Future<void> _onResendCodeRequested(
      ResendCodeRequested event, Emitter<SignupState> emit) async {
    emit(ResendOtpLoading());
    var data = await resendValidationUC.call(email: event.email);

    data.fold(
      (error) => emit(ResendCodeFailure(error: error)),
      (response) => emit(ResendCodeSuccess()),
    );
  }

  Future<void> _onPickProfileImage(
      OnProfileImagePicked event, Emitter<SignupState> emit) async {
    profileImage = (await FileService.pickImage())?.path;
    emit(SignupProfileImagePicked());
  }

  Future<void> _onUpdateDataRequested(
      UpdateDataRequested event, Emitter<SignupState> emit) async {
    emit(SignupLoading());

    var data = await updateDataUc.call(
      CompleteDto(
        phoneNumber: phoneNumber?.phoneNumber,
        userName: userNameController.text,
        college: collegeController.text,
        dateOfBirth: dateOfBirthController.text,
        gpa: double.parse(gpaController.text),
        level: int.parse(levelController.text),
        position: position?.toLowerCase(),
        university: universityController.text,
        profilePicture: profileImage,
        gender: gender,
        profile: Profile(
          bio: bioController.text,
          interests: event.interests,
        ),
      ),
    );

    data.fold(
      (error) => emit(UpdateDataFailure(error: error)),
      (response) => emit(UpdateDataSuccess()),
    );
  }
}
