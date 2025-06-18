import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/features/profile/domain/repo/profile_repository.dart';

class FollowUserUc {
  final ProfileRepository profileRepository;

  FollowUserUc(this.profileRepository);

  Future<Either<Failure, String>> follow({required String userId}) => profileRepository.follow(userId);

  Future<Either<Failure, String>> unfollow({required String userId}) => profileRepository.unfollow(userId);}