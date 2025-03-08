import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/otp_dto.dart';
import '../repo/verify_forget_password_repo.dart';

class VerifyForgetPasswordUc {
  final VerifyPasswordRepo verifyPasswordRepo;

  VerifyForgetPasswordUc({required this.verifyPasswordRepo});

  Future<Either<Failure, String>> call(
      OtpDto otpDto) =>
      verifyPasswordRepo.verifyForgetPassword(otpDto);
}
