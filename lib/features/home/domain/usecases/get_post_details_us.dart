import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/post_model/post.dart';
import '../repo/posts_repository.dart';

class GetPostDetailsUC {
  final PostRepository getPostsRepo;

  GetPostDetailsUC(this.getPostsRepo);

  Future<Either<Failure, Discussion>> call({required String postId}) =>
      getPostsRepo.getPostId(postId: postId);
}
