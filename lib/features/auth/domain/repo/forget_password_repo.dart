import 'package:dartz/dartz.dart';
import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/forget_password_response/forget_password_response.dart';

abstract class ForgetPasswordRepo {
  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword(
      {required String email});
}
