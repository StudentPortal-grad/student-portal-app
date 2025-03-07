import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model/error_model.dart';

import '../../../auth/data/model/user_model/user.dart';
import '../../data/dto/update_profile_dto.dart';
import '../repo/profile_repository.dart';

class UpdateMyProfileUC {
  final ProfileRepository profileRepository;

  UpdateMyProfileUC({required this.profileRepository});

  Future<Either<Failure, User>> call(UpdateProfileDto updateProfileDto) =>
      profileRepository.updateProfile(updateProfileDto: updateProfileDto);
}
