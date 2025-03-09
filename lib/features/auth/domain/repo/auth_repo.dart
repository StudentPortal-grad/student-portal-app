import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/complete_dto.dart';
import '../../data/dto/login_dto.dart';
import '../../data/dto/otp_dto.dart';
import '../../data/dto/set_new_password_dto.dart';
import '../../data/dto/signup_otp_dto.dart';
import '../../data/dto/signup_request.dart';
import '../../data/model/check_email_response/check_email_response.dart';
import '../../data/model/signup_response/signup_response.dart';
import '../../data/model/update_response/update_response.dart';


abstract class AuthRepository {
  /// User Signup & Login
  Future<Either<Failure, SignupResponse>> signup({required SignupDTO signupRequest});
  Future<Either<Failure, bool>> login({required LoginDTO loginRequest});

  /// Email Verification
  Future<Either<Failure, bool>> verifyEmail(SignupOtpDto signupOtpDTO);
  Future<Either<Failure, CheckEmailResponse>> resendVerification({required String email});

  /// Password Reset
  Future<Either<Failure, String>> forgetPassword({required String email}); // Consider returning a ResetTokenDTO
  Future<Either<Failure, String>> verifyForgetPassword(OtpDto otpDTO);
  Future<Either<Failure, bool>> setNewPassword(SetNewPasswordDto setNewPasswordDTO);

  /// User Profile Update
  Future<Either<Failure, UpdateResponse>> completeProfile(CompleteDto completeDTO);

  /// logout
  Future<Either<Failure, String>> logout();
}
