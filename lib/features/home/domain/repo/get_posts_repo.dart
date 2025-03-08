import 'package:dartz/dartz.dart';
import 'package:student_portal/features/home/data/model/post_model/post.dart';

import '../../../../core/errors/data/model/error_model.dart';

abstract class GetPostsRepo {
  Future<Either<Failure, List<Post>>> getPosts();
}
