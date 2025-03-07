import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/dto/login_dto.dart';


abstract class LoginRepo {
  Future<Either<Failure, bool>> login({
    required LoginDTO loginRequest,
  });
}
