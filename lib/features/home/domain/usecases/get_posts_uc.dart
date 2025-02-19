import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../data/model/post_model/post.dart';
import '../repo/get_posts_repo.dart';

class GetPostsUc {
  final GetPostsRepo getPostsRepo;

  GetPostsUc({required this.getPostsRepo});

  Future<Either<Failure, List<Post>>> call({required String email}) =>
      getPostsRepo.getPosts();
}
