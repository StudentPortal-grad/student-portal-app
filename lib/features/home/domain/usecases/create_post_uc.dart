import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/post_dto.dart';
import '../repo/get_posts_repo.dart';

class CreatePostUc {
  final PostRepository getPostsRepo;

  CreatePostUc(this.getPostsRepo);

  Future<Either<Failure, String>> call({
    required PostDto postDto,
    void Function(int percent)? onProgress,
  }) => getPostsRepo.createPost(postDto: postDto, onProgress: onProgress);
}
