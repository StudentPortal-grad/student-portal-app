import 'package:dartz/dartz.dart';
import 'package:student_portal/features/profile/domain/repo/profile_repository.dart';

import '../../../../core/errors/data/model/error_model.dart';

class BlockUserUc {
  final ProfileRepository profileRepository;

  BlockUserUc(this.profileRepository);

  Future<Either<Failure, String>> block({required String userId}) => profileRepository.block(userId);

  Future<Either<Failure, String>> unBlock({required String userId}) => profileRepository.unBlock(userId);
}
