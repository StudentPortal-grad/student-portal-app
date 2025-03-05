import 'package:dartz/dartz.dart';
import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/dto/set_new_password_dto.dart';

abstract class ResetPasswordRepo {
  Future<Either<Failure, bool>> setNewPassword(SetNewPasswordDto setNewPasswordDto);
}
