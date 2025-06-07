import 'package:dartz/dartz.dart';

import '../../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/upload_resource.dart';
import '../repo/resource_repository.dart';

class UploadResources {
  final ResourceRepository repository;

  UploadResources(this.repository);

  Future<Either<Failure, String>> call({
    required ResourceDto resourceDto,
    void Function(int percent)? onProgress,
  }) =>
      repository.uploadResource(
          resourceDto: resourceDto, onProgress: onProgress);
}
