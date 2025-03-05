import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../repo/forget_password_repo.dart';

class ForgetPasswordUc {
  final ForgetPasswordRepo forgetPasswordRepo;

  ForgetPasswordUc({required this.forgetPasswordRepo});



  Future<Either<Failure, String>> call({
    required String email,
  }) async {
    return forgetPasswordRepo.forgetPassword(email: email);
  }
}