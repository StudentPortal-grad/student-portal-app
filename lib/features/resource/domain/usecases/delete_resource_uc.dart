import 'package:dartz/dartz.dart';
import 'package:student_portal/features/resource/domain/repo/resource_repository.dart';

import '../../../../core/errors/data/model/error_model.dart';

class DeleteResourceUc {
  final ResourceRepository resourceRepository;

  DeleteResourceUc(this.resourceRepository);

  Future<Either<Failure, String>> call({required String resourceId}) => resourceRepository.deleteResource(resourceId: resourceId);
}