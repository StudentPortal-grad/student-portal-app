import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/core/network/api_endpoints.dart';
import 'package:student_portal/core/network/api_service.dart';
import 'package:student_portal/features/home/data/dto/reply_dto.dart';
import 'package:student_portal/features/home/data/dto/vote_dto.dart';

import '../../../../core/errors/data/model/failures.dart';
import '../../domain/repo/posts_repository.dart';
import '../dto/post_dto.dart';
import '../model/post_model/post.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiService apiService;

  PostRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, List<Discussion>>> getPosts({int page = 1}) async {
    try {
      final response = await apiService.get(
          endpoint: ApiEndpoints.discussions,
          query: {
        'limit': 5,
        'page': page,
        'currVoteSpecified': true,
        'ai_enabled': true,
      });
      log('posts :: $response');
      return Right(response['data']['discussions'].map<Discussion>((e) => Discussion.fromJson(e)).toList());
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    } catch (e) {
      log('UnexpectedFailure ${e.toString()}');
      return Left(Failure(message: 'Unexpected Error'));
    }
  }

  @override
  Future<Either<Failure, Discussion>> getPostId({required String postId}) async {
    try{
      final response = await apiService.get(
          endpoint: ApiEndpoints.discussionID(postId),
          query: {'currVoteSpecified': true});
      log('post :: $response');
      return Right(Discussion.fromJson(response['data']));
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }


  @override
  Future<Either<Failure, String>> createPost({
    required PostDto postDto,
    void Function(int percent)? onProgress,
  }) async {
    try {
      log('Creating a post ::: ${postDto.toJson()}');
      final response = await apiService.post(
          endpoint: ApiEndpoints.discussions,
          formData: await postDto.toFormData(),
          onSendProgress: (int sent, int total) {
            if (total > 0) {
              final percent = ((sent / total) * 100).toInt();
              log('Creating a post percent :: $percent $sent $total');
              onProgress?.call(percent);
            }
          });
      log('Creating post :: $response');
      return Right(response['message'] ?? 'Success');
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }

  @override
  Future<Either<Failure, String>> deletePost({required String postId}) async {
    try {
      log('Deleting a post ::: $postId');
      final response = await apiService.delete(endpoint: ApiEndpoints.discussionID(postId));
      log('Deleting a post :: $response');
      return Right(response['message'] ?? 'Success');
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }

  @override
  Future<Either<Failure, String>> reply(
      {required ReplyDto replyDto}) async {
    try {
      log('Replying a post ::: ${replyDto.toJson()}');
      final response = await apiService.post(
        endpoint: ApiEndpoints.discussionReply(replyDto.id),
        data: replyDto.toJson(),
      );
      log('Replying a post :: $response');
      return Right(response['message'] ?? 'Success');
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }

  @override
  Future<Either<Failure, String>>deleteReply({required String replyId,required String postId})async{
    try {
      log('Deleting a replyId ::: $replyId');
      final response = await apiService.delete(endpoint: '${ApiEndpoints.discussionID(postId)}/${ApiEndpoints.postReplyDelete(replyId)}');
      log('Deleting a replyId :: $response');
      return Right(response['message'] ?? 'Success');
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, String>> vote({required VoteDto voteDto}) async {
    try {
      log('Voting a post ::: ${voteDto.toJson()}');
      final response = await apiService.post(
        endpoint: ApiEndpoints.discussionVote(voteDto.postId),
        data: voteDto.toJson(),
      );
      log('Voting a post :: $response');
      return Right(response['message'] ?? 'Success');
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }

}
