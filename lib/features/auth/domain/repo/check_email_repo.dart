import 'package:dartz/dartz.dart';
import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/check_email_response/check_email_response.dart';

abstract class CheckEmailRepo {
  Future<Either<Failure, CheckEmailResponse>> checkEmail({
    required String email,
  });
}
