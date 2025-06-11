import 'package:dartz/dartz.dart';
import 'package:student_portal/features/resource/domain/repo/resource_repository.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/resource.dart';

class GetResourceDetails {
  final ResourceRepository resourceRepository;

  GetResourceDetails(this.resourceRepository);

  Future<Either<Failure, Resource>> call({required String resourceId}) => resourceRepository.getResourceId(resourceId: resourceId);
}