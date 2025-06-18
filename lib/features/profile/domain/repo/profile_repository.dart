import 'package:dartz/dartz.dart';
import 'package:student_portal/features/profile/data/dto/update_profile_dto.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../auth/data/model/user_model/user.dart';
import '../../data/dto/change_password_dto.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getMyProfile();

  Future<Either<Failure, User>> updateProfile({required UpdateProfileDto updateProfileDto});

  Future<Either<Failure, User>> getUserProfile({required String userId});

  Future<Either<Failure, String>> changePassword({required ChangePasswordDto changePasswordDto});

  Future<Either<Failure, String>> follow(String userId);

  Future<Either<Failure, String>> unfollow(String userId);

  Future<Either<Failure, String>> block(String userId);

  Future<Either<Failure, String>> unBlock(String userId);
}
