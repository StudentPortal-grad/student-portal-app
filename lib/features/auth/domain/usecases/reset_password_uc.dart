import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/set_new_password_dto.dart';
import '../repo/reset_password_repo.dart';

class ResetPasswordUc {
  final ResetPasswordRepo resetPasswordRepo;

  ResetPasswordUc({required this.resetPasswordRepo});

  Future<Either<Failure, bool>> call(
      {required SetNewPasswordDto setNewPasswordDto}) async {
    return resetPasswordRepo.setNewPassword(setNewPasswordDto);
  }
}
