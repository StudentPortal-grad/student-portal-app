import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/check_email_response/check_email_response.dart';
import '../repo/auth_repo.dart';

class ResendValidationUC {
  final AuthRepository authRepository;

  ResendValidationUC({required this.authRepository});

  Future<Either<Failure, CheckEmailResponse>> call({required String email}) => authRepository.resendVerification(email: email);
}
