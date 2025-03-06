import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/dto/complete_dto.dart';
import '../../data/model/update_response/update_response.dart';

abstract class UpdateDataRepo {
  Future<Either<Failure, UpdateResponse>> update(CompleteDto completeDto);
}
