import 'package:dartz/dartz.dart';
import 'package:student_portal/features/profile/domain/repo/profile_repository.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../auth/data/model/user_model/user.dart';

class GetMyProfileUs {
  final ProfileRepository profileRepository;

  GetMyProfileUs({required this.profileRepository});

  Future<Either<Failure, User>> call() => profileRepository.getMyProfile();
}
