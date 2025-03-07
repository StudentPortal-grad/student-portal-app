import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/dto/login_dto.dart';
import '../repo/login_repo.dart';

class LoginUc {
  final LoginRepo loginRepo;

  LoginUc({required this.loginRepo});

  Future<Either<Failure, bool>> call(
          {required LoginDTO loginRequest}) =>
      loginRepo.login(loginRequest: loginRequest);
}
