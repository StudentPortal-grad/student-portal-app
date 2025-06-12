import 'package:dartz/dartz.dart';
import 'package:student_portal/features/home/data/model/post_model/post.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/post_dto.dart';
import '../../data/dto/reply_dto.dart';
import '../../data/dto/vote_dto.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Discussion>>> getPosts({int page = 1});

  Future<Either<Failure, Discussion>> getPostId({required String postId});

  Future<Either<Failure, String>> createPost({
    required PostDto postDto,
    void Function(int percent)? onProgress,
  });

  Future<Either<Failure, String>> deletePost({required String postId});

  Future<Either<Failure, String>> vote({required VoteDto voteDto});

  Future<Either<Failure, String>> reply({required ReplyDto replyDto});

  Future<Either<Failure, String>> deleteReply({required String replyId,required String postId});
}
