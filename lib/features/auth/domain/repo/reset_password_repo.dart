import 'package:dartz/dartz.dart';
import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/reset_password_response/reset_password_response.dart';

abstract class ResetPasswordRepo {
  Future<Either<Failure, ResetPasswordResponse>> setNewPassword(
      {required String resetToken, required String password});
}
