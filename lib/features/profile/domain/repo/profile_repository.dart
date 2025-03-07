import 'package:dartz/dartz.dart';
import 'package:student_portal/features/profile/data/dto/update_profile_dto.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../auth/data/model/user_model/user.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getMyProfile();

  Future<Either<Failure, User>> updateProfile({required UpdateProfileDto updateProfileDto});

  Future<Either<Failure, User>> getUserProfile({required String userId});
}
