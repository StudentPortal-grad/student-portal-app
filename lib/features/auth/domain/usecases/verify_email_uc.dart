import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/verify_response/verify_response.dart';
import '../repo/verify_email_repo.dart';

class VerifyEmailUc {
  final VerifyEmailRepo verifyEmailRepo;

  VerifyEmailUc({required this.verifyEmailRepo});

  Future<Either<Failure, VerifyResponse>> call(
          {required String pinCode, required String email}) =>
      verifyEmailRepo.verifyEmail(pinCode: pinCode, email: email);
}
