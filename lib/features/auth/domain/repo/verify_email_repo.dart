import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/signup_otp_dto.dart';

abstract class VerifyEmailRepo {
  Future<Either<Failure, bool>> verifyEmail(SignupOtpDto signupOtpDto);
}
