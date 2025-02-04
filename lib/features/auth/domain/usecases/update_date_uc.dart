import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/token_model/token_model.dart';
import '../../data/model/update_response/update_response.dart';
import '../repo/update_data_repo.dart';

class UpdateDateUc {
  final UpdateDataRepo updateDataRepo;

  UpdateDateUc({required this.updateDataRepo});

  Future<Either<Failure, UpdateResponse>> call({
    required TokenModel tokenModel,
    required Map<String, dynamic>? jsonData,
  }) async {
    return updateDataRepo.update(tokenModel: tokenModel, jsonData: jsonData);
  }
}
