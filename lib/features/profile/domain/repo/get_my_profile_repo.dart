import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../auth/data/model/user_model/user.dart';

abstract class GetMyProfileRepo {
  Future<Either<Failure, User>> getMyProfile();
}
