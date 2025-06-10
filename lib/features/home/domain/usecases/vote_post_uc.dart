import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/vote_dto.dart';
import '../repo/posts_repository.dart';

class VotePostUc {
  final PostRepository getPostsRepo;

  VotePostUc(this.getPostsRepo);

  Future<Either<Failure, String>> call({required VoteDto voteDto}) => getPostsRepo.vote(voteDto: voteDto);
}
