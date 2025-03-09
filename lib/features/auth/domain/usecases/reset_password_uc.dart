import 'package:dartz/dartz.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/set_new_password_dto.dart';

class ResetPasswordUc {
  final AuthRepository authRepository;

  ResetPasswordUc({required this.authRepository});

  Future<Either<Failure, bool>> call({required SetNewPasswordDto setNewPasswordDto}) async {
    return authRepository.setNewPassword(setNewPasswordDto);
  }
}
