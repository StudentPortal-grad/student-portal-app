import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/post_model/post.dart';
import '../repo/posts_repository.dart';

class GetPostsUc {
  final PostRepository getPostsRepo;

  GetPostsUc({required this.getPostsRepo});

  Future<Either<Failure, List<Discussion>>> call({int page = 1}) => getPostsRepo.getPosts(page: page);
}
