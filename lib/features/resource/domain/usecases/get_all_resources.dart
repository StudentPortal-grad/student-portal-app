import 'package:dartz/dartz.dart';

import '../../../../../core/errors/data/model/error_model.dart';
import '../../data/model/resource.dart';
import '../repo/resource_repository.dart';

class GetAllResourcesUc {
  final ResourceRepository repository;

  GetAllResourcesUc(this.repository);

  Future<Either<Failure, List<Resource>>> call({int page = 1}) => repository.getResources(page: page);
}
