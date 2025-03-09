import 'package:dartz/dartz.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/errors/data/model/error_model.dart';

class ForgetPasswordUc {
  final AuthRepository authRepository;

  ForgetPasswordUc({required this.authRepository});

  Future<Either<Failure, String>> call({required String email}) async {
    return authRepository.forgetPassword(email: email);
  }
}
