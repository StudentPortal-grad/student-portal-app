import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../repo/verify_forget_password_repo.dart';

class VerifyForgetPasswordUc {
  final VerifyPasswordRepo verifyPasswordRepo;

  VerifyForgetPasswordUc({required this.verifyPasswordRepo});

  Future<Either<Failure, String>> call(
          {required String pinCode, required String email}) =>
      verifyPasswordRepo.verifyForgetPassword(pinCode: pinCode, email: email);
}
