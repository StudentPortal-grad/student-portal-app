import 'package:dartz/dartz.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/otp_dto.dart';

class VerifyForgetPasswordUc {
  final AuthRepository authRepository;

  VerifyForgetPasswordUc({required this.authRepository});

  Future<Either<Failure, String>> call(OtpDto otpDto) => authRepository.verifyForgetPassword(otpDto);
}
