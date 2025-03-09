import 'package:dartz/dartz.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/signup_request.dart';
import '../../data/model/signup_response/signup_response.dart';

class SignupUc {
  final AuthRepository authRepository;

  SignupUc({required this.authRepository});

  Future<Either<Failure, SignupResponse>> call({required SignupDTO signupRequest}) => authRepository.signup(signupRequest: signupRequest);
}
