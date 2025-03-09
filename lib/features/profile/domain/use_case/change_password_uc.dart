import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/change_password_dto.dart';
import '../repo/profile_repository.dart';

class ChangePasswordUc {
  final ProfileRepository profileRepository;

  ChangePasswordUc({required this.profileRepository});

  Future<Either<Failure, String>> call(ChangePasswordDto changePasswordDto) => profileRepository.changePassword(changePasswordDto: changePasswordDto);
}