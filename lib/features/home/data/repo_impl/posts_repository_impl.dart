import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/core/network/api_endpoints.dart';
import 'package:student_portal/core/network/api_service.dart';

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
      final response = await apiService.get(endpoint: ApiEndpoints.discussions,query: {
        'limit': '5',
        'page': page,
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
}
