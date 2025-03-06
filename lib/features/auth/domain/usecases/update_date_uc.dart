import 'package:dartz/dartz.dart';
import 'package:student_portal/features/auth/data/dto/complete_dto.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/token_model/token_model.dart';
import '../../data/model/update_response/update_response.dart';
import '../repo/update_data_repo.dart';

class UpdateDateUc {
  final UpdateDataRepo updateDataRepo;

  UpdateDateUc({required this.updateDataRepo});

  Future<Either<Failure, UpdateResponse>> call(CompleteDto completeDto) async {
    return updateDataRepo.update(completeDto);
  }
}
