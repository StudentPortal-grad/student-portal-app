import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../auth/data/model/user_model/user.dart';
import '../repo/profile_repository.dart';

class GetUserProfileUc {
  final ProfileRepository profileRepository;

  GetUserProfileUc({required this.profileRepository});

  Future<Either<Failure, User>> call({required String userId}) =>
      profileRepository.getUserProfile(userId: userId);
}
