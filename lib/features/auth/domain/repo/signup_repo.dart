import 'package:dartz/dartz.dart';
import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/dto/signup_request.dart';
import '../../data/model/signup_response/signup_response.dart';


abstract class SignupRepo {
  Future<Either<Failure, SignupResponse>> signup({
    required SignupDTO signupRequest,
  });
}
