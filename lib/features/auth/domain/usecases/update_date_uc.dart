import 'package:dartz/dartz.dart';
import 'package:student_portal/features/auth/data/dto/complete_dto.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/update_response/update_response.dart';

class CompleteProfileUC {
  final AuthRepository authRepository;

  CompleteProfileUC({required this.authRepository});

  Future<Either<Failure, UpdateResponse>> call(CompleteDto completeDto) async {
    return authRepository.completeProfile(completeDto);
  }
}
