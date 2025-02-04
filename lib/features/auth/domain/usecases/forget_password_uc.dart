import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/forget_password_response/forget_password_response.dart';
import '../repo/forget_password_repo.dart';

class ForgetPasswordUc {
  final ForgetPasswordRepo forgetPasswordRepo;

  ForgetPasswordUc({required this.forgetPasswordRepo});



  Future<Either<Failure, ForgetPasswordResponse>> call({
    required String email,
  }) async {
    return forgetPasswordRepo.forgetPassword(email: email);
  }
}