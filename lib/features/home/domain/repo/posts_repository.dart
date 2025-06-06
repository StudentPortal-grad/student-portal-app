import 'package:dartz/dartz.dart';
import 'package:student_portal/features/home/data/model/post_model/post.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/post_dto.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();

  Future<Either<Failure, String>> createPost({
    required PostDto postDto,
    void Function(int percent)? onProgress,
  });
}
