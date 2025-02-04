import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/check_email_response/check_email_response.dart';
import '../repo/check_email_repo.dart';

class CheckEmailUc {
final CheckEmailRepo checkEmailRepo;

  CheckEmailUc({required this.checkEmailRepo});

  Future<Either<Failure, CheckEmailResponse>> call({required String email}) => checkEmailRepo.checkEmail(email: email);
}