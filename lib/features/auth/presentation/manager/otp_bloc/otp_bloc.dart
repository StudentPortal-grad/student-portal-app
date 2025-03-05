import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/features/auth/domain/usecases/verify_email_uc.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/repo_impl/check_email_impl.dart';
import '../../../data/repo_impl/forget_password_impl.dart';
import '../../../data/repo_impl/verify_email_impl.dart';
import '../../../data/repo_impl/verify_forget_password_impl.dart';
import '../../../domain/usecases/check_email_uc.dart';
import '../../../domain/usecases/forget_password_uc.dart';
import '../../../domain/usecases/verify_forget_password_uc.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final VerifyEmailUc verifyEmailUc = VerifyEmailUc(
      verifyEmailRepo: VerifyEmailRepoImpl(getIt.get<ApiService>()));
  final VerifyForgetPasswordUc verifyForgetPasswordUc = VerifyForgetPasswordUc(
      verifyPasswordRepo: VerifyForgetPasswordImpl(getIt.get<ApiService>()));

  final ForgetPasswordUc forgetPasswordUc = ForgetPasswordUc(
      forgetPasswordRepo: ForgetPasswordImpl(getIt.get<ApiService>()));

  final CheckEmailUc checkEmailUc =
      CheckEmailUc(checkEmailRepo: CheckEmailRepoImpl(getIt.get<ApiService>()));

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
    isValidate = event.pinCode.length == 4;
    emit(OtpInputChanged(otpValid: event.pinCode.length == 4));
  }

  Future<void> _onSendOtpForgetPassword(
      SendOtpForgetPassword event, Emitter<OtpState> emit) async {
    emit(OtpLoading());

    var data = await verifyForgetPasswordUc.call(
      pinCode: event.pinCode,
      email: event.email,
    );

    data.fold(
      (error) => emit(OtpFailure(error)),
      (response) => emit(OtpSuccess()),
    );
  }

  Future<void> _onSendOtpVerify(
      SendOtpVerify event, Emitter<OtpState> emit) async {
    if (state is OtpLoading) return;

    emit(OtpLoading());

    var data = await checkEmailUc.call(email: event.email);

    data.fold(
      (error) => emit(SendOtpFailure(error)),
      (response) => emit(SendOtpSuccess()),
    );
  }

  Future<void> _onVerifyEmail(VerifyEmail event, Emitter<OtpState> emit) async {
    emit(OtpLoading());

    var data = await verifyEmailUc.call(
      pinCode: event.pinCode,
      email: event.email,
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
