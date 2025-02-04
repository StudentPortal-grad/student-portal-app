import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/verify_response/verify_response.dart';

abstract class VerifyEmailRepo {
  Future<Either<Failure, VerifyResponse>> verifyEmail(
      {required String pinCode, required String email});
}
