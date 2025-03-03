import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/dto/login_request.dart';
import '../../data/model/login_response/login_response.dart';


abstract class LoginRepo {
  Future<Either<Failure, LoginResponse>> login({
    required LoginRequest loginRequest,
  });
}
