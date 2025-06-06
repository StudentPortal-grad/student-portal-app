import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';

import '../../data/dto/upload_resource.dart';

abstract class ResourceRepository {
  Future<Either<Failure, String>> uploadResource({
    required ResourceDto resourceDto,
    void Function(int percent)? onProgress,
  });
}
