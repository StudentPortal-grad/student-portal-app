import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/signup_request.dart';
import '../../data/model/signup_response/signup_response.dart';
import '../repo/signup_repo.dart';

class SignupUc {
  final SignupRepo signupRepo;

  SignupUc({required this.signupRepo});

  Future<Either<Failure, SignupResponse>> call(
          {required SignupDTO signupRequest}) =>
      signupRepo.signup(signupRequest: signupRequest);
}
