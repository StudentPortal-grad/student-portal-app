import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../repo/posts_repository.dart';

class DeleteCommentUc {
  final PostRepository postRepository;

  DeleteCommentUc(this.postRepository);

  Future<Either<Failure, String>> call({required String replyId,required String postId}) => postRepository.deleteReply(replyId: replyId,postId: postId);
}
