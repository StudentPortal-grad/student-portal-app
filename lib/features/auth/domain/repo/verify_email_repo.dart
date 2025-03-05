import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';

abstract class VerifyEmailRepo {
  Future<Either<Failure, bool>> verifyEmail(
      {required String pinCode, required String email});
}
