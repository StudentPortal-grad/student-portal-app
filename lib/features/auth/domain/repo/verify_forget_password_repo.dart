import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';

abstract class VerifyPasswordRepo {
  Future<Either<Failure, String>> verifyForgetPassword(
      {required String pinCode, required String email});
}
