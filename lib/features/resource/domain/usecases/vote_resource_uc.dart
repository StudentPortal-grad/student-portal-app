import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../home/data/dto/vote_dto.dart';
import '../repo/resource_repository.dart';

class VoteResourceUc {
  final ResourceRepository resourceRepository;

  VoteResourceUc(this.resourceRepository);

  Future<Either<Failure, String>> call({required VoteDto voteDto}) => resourceRepository.vote(voteDto: voteDto);
}
