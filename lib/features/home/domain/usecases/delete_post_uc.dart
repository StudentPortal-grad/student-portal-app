import 'package:dartz/dartz.dart';
import 'package:student_portal/features/home/domain/repo/posts_repository.dart';

import '../../../../core/errors/data/model/error_model.dart';

class DeletePostUc {
  final PostRepository postRepository;

  DeletePostUc(this.postRepository);
 Future<Either<Failure, String>> call({required String postId}) async => await postRepository.deletePost(postId: postId);
}
