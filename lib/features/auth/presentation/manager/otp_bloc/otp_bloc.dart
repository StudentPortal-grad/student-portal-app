import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/features/auth/data/dto/otp_dto.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';
import 'package:student_portal/features/auth/domain/usecases/verify_email_uc.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/dto/signup_otp_dto.dart';
import '../../../domain/usecases/check_email_uc.dart';
import '../../../domain/usecases/forget_password_uc.dart';
import '../../../domain/usecases/verify_forget_password_uc.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final VerifyEmailUc verifyEmailUc = VerifyEmailUc(
      authRepository: getIt.get<AuthRepository>());
  final VerifyForgetPasswordUc verifyForgetPasswordUc = VerifyForgetPasswordUc(authRepository: getIt.get<AuthRepository>());

  final ForgetPasswordUc forgetPasswordUc = ForgetPasswordUc(authRepository: getIt.get<AuthRepository>());

  final ResendValidationUC resendValidationUC = ResendValidationUC(authRepository: getIt.get<AuthRepository>());

  OtpBloc() : super(OtpInitial()) {
    on<SendOtpForgetPassword>(_onSendOtpForgetPassword);
    on<SendOtpVerify>(_onSendOtpVerify);
    on<VerifyEmail>(_onVerifyEmail);
    on<ResendEmail>(_onResendEmail);
    on<OtpCodeChanged>(_onOtpCodeChanged);
  }

  String otpCode = '';
  bool isValidate = false;

  void _onOtpCodeChanged(OtpCodeChanged event, Emitter<OtpState> emit) {
    otpCode = event.pinCode;
    isValidate = (event.pinCode.length == 6);
    emit(OtpInputChanged(otpValid: isValidate));
  }

  Future<void> _onSendOtpForgetPassword(
      SendOtpForgetPassword event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    var data = await verifyForgetPasswordUc.call(OtpDto(
      pinCode: otpCode,
      email: event.email,
    ));
    data.fold(
      (error) => emit(OtpFailure(error)),
      (response) => emit(OtpSuccess()),
    );
  }

  Future<void> _onSendOtpVerify(
      SendOtpVerify event, Emitter<OtpState> emit) async {
    if (state is OtpLoading) return;

    emit(OtpLoading());

    var data = await resendValidationUC.call(email: event.email);

    data.fold(
      (error) => emit(SendOtpFailure(error)),
      (response) => emit(SendOtpSuccess()),
    );
  }

// not used yet
  Future<void> _onVerifyEmail(VerifyEmail event, Emitter<OtpState> emit) async {
    emit(OtpLoading());

    var data = await verifyEmailUc.call(
        SignupOtpDto (
          pinCode: otpCode,
          email: event.email,
        )
    );

    data.fold(
      (error) => emit(OtpFailure(error)),
      (response) => emit(OtpSuccess()),
    );
  }

  Future<void> _onResendEmail(ResendEmail event, Emitter<OtpState> emit) async {
    if (state is ResendEmailLoading) return;

    emit(ResendEmailLoading());

    var data = await forgetPasswordUc.call(email: event.email);

    data.fold(
      (error) => emit(ResendEmailFailure(error)),
      (response) => emit(ResendEmailSuccess(response)),
    );
  }
}
