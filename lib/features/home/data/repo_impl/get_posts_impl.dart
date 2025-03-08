import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';

import '../../../../core/errors/data/model/failures.dart';
import '../../domain/repo/get_posts_repo.dart';
import '../model/post_model/post.dart';

class GetPostsImpl implements GetPostsRepo {
  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      // final response = await _dio.get('/posts');
      // final post = Post.fromJson(response.data);
      log('posts');
      return Right([]);
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }  catch (e) {
      log('UnexpectedFailure ${e.toString()}');
      return Left(Failure(message:'Unexpected Error'));
      // return Left(UnexpectedFailure(e.toString())); // Handle unexpected errors
    }
  }
}
