import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/dto/login_request.dart';
import '../repo/login_repo.dart';

class LoginUc {
  final LoginRepo loginRepo;

  LoginUc({required this.loginRepo});

  Future<Either<Failure, bool>> call(
          {required LoginRequest loginRequest}) =>
      loginRepo.login(loginRequest: loginRequest);
}
