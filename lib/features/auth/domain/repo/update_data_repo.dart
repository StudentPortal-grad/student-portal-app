import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/token_model/token_model.dart';
import '../../data/model/update_response/update_response.dart';

abstract class UpdateDataRepo {
  Future<Either<Failure, UpdateResponse>> update({
    required TokenModel tokenModel,
    required Map<String, dynamic>? jsonData,
  });

/*  Future<Either<Failure, UpdateResponse>> uploadFile({
    required File file,
    required TokenModel tokenModel,
  });*/
}
