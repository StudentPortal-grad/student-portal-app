import 'package:dartz/dartz.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/signup_otp_dto.dart';

class VerifyEmailUc {
  final AuthRepository authRepository;

  VerifyEmailUc({required this.authRepository});

  Future<Either<Failure, bool>> call(SignupOtpDto signupOtpDto) => authRepository.verifyEmail(signupOtpDto);
}
