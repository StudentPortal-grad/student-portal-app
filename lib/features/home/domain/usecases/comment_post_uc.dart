import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/reply_dto.dart';
import '../../data/model/post_model/post.dart';
import '../repo/posts_repository.dart';

class CommentPostUc {
  final PostRepository getPostsRepo;

  CommentPostUc(this.getPostsRepo);

  Future<Either<Failure, Discussion>> call({required ReplyDto replyDto}) =>
      getPostsRepo.reply(replyDto: replyDto);
}
