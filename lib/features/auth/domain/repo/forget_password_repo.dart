import 'package:dartz/dartz.dart';
import '../../../../core/errors/data/model/error_model/error_model.dart';

abstract class ForgetPasswordRepo {
  Future<Either<Failure, String>> forgetPassword(
      {required String email});
}
