import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/core/network/api_service.dart';
import 'package:student_portal/features/home/data/dto/reply_dto.dart';
import 'package:student_portal/features/home/data/dto/vote_dto.dart';

import 'package:student_portal/features/resource/data/dto/upload_resource.dart';
import 'package:student_portal/features/resource/data/model/resource.dart';

import '../../../../../core/errors/data/model/failures.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../domain/repo/resource_repository.dart';

class ResourceRepositoryImpl implements ResourceRepository {
  final ApiService apiService;

  ResourceRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, String>> uploadResource({
    required ResourceDto resourceDto,
    void Function(int percent)? onProgress,
  }) async {
    try {
      log('Creating a Resource ::: ${resourceDto.toJson()}');
      final response = await apiService.post(
          endpoint: ApiEndpoints.resources,
          formData: await resourceDto.toFormData(),
          onSendProgress: (int sent, int total) {
            if (total > 0) {
              final percent = ((sent / total) * 100).toInt();
              log('Creating a Resource percent :: $percent $sent $total');
              onProgress?.call(percent);
            }
          });
      log('Creating Resource :: $response');
      return Right(response['message'] ?? 'Success');
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }

  @override
  Future<Either<Failure, List<Resource>>> getResources({int page = 1}) async{
    try {
      var data = await apiService.get(
          endpoint: ApiEndpoints.resources, query: {'page': page, 'limit': 5});
      log("RESOURCES:: $data");
      return Right(data['data']['resources'].map<Resource>((e) => Resource.fromJson(e)).toList());
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, String>> deleteResource({required String resourceId}) async {
    try {
      log('Deleting a resource ::: $resourceId');
      final response = await apiService.delete(
          endpoint: ApiEndpoints.resourcesID(resourceId));
      log('Deleting a resource :: $response');
      return Right(response['message'] ?? 'Success');
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }

  @override
  Future<Either<Failure, Resource>> getResourceId({required String resourceId}) async {
    try {
      final response = await apiService.get(
        endpoint: ApiEndpoints.resourcesID(resourceId),
        query: {'currVoteSpecified': true},
      );
      log('Resource :: $response');
      return Right(Resource.fromJson(response['data']));
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }

  @override
  Future<Either<Failure, String>> reply({required ReplyDto replyDto}) async {
    try {
      log('Replying a resource ::: ${replyDto.toJson()}');
      final response = await apiService.post(
        endpoint: ApiEndpoints.resourcesReply(replyDto.id),
        data: replyDto.toJson(),
      );
      log('Replying a resource :: $response');
      return Right(response['message'] ?? 'Success');
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }

  @override
  Future<Either<Failure, String>> vote({required VoteDto voteDto}) async {
    try {
      log('Voting a resource ::: ${voteDto.toJson()}');
      final response = await apiService.post(
        endpoint: ApiEndpoints.discussionVote(voteDto.postId),
        data: voteDto.toJson(),
      );
      log('Voting a resource :: $response');
      return Right(response['message'] ?? 'Success');
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }
}
