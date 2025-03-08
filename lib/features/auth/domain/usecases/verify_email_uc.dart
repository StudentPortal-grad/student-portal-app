import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/signup_otp_dto.dart';
import '../repo/verify_email_repo.dart';

class VerifyEmailUc {
  final VerifyEmailRepo verifyEmailRepo;

  VerifyEmailUc({required this.verifyEmailRepo});

  Future<Either<Failure, bool>> call(
      SignupOtpDto signupOtpDto) =>
      verifyEmailRepo.verifyEmail(signupOtpDto);
}
