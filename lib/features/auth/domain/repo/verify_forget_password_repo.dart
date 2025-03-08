import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/otp_dto.dart';

abstract class VerifyPasswordRepo {
  Future<Either<Failure, String>> verifyForgetPassword(OtpDto otpDto);
}
