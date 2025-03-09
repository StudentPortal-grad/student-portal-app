import 'package:dartz/dartz.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/login_dto.dart';

class LoginUc {
  final AuthRepository authRepository;

  LoginUc({required this.authRepository});

  Future<Either<Failure, bool>> call({required LoginDTO loginRequest}) => authRepository.login(loginRequest: loginRequest);
}
