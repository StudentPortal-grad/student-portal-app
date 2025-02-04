import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/reset_password_response/reset_password_response.dart';
import '../repo/reset_password_repo.dart';

class ResetPasswordUc {
  final ResetPasswordRepo resetPasswordRepo;

  ResetPasswordUc({required this.resetPasswordRepo});

  Future<Either<Failure, ResetPasswordResponse>> call({
    required String resetToken,
    required String password,
  }) async {
    return resetPasswordRepo.setNewPassword(
        resetToken: resetToken, password: password);
  }
}
