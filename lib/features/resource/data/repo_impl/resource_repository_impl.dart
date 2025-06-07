import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/core/network/api_service.dart';

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
}
