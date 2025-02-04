// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/repo/user_repository.dart';
import '../../domain/repo/update_data_repo.dart';
import '../model/token_model/token_model.dart';
import '../model/update_response/update_response.dart';


class UpdateDataImpl implements UpdateDataRepo {
  final ApiService apiService;

  UpdateDataImpl(this.apiService);

  @override
  Future<Either<Failure, UpdateResponse>> update({
    required TokenModel tokenModel,
    required Map<String, dynamic>? jsonData,
  }) async {
    try {
      log("update DTO: $jsonData");
      var data = await apiService.patch(
        endpoint: ApiEndpoints.updateUser(tokenModel.id!),
        data: jsonData,
        token: tokenModel.accessToken,
        refreshToken: tokenModel.refreshToken,
      );
      var response = UpdateResponse.fromJson(data);
      UserRepository.setUser(response.data);
      log("Update Response: ${response.toString()}");
      return Right(response);
    } on DioException catch (e) {
      log((e.toString()));
      return Left(ServerFailure.fromDioError(e));
    }
  }

/*  @override
  Future<Either<Failure, UpdateResponse>> uploadFile({
    required File file,
    required TokenModel tokenModel,
  }) async {
    try {
      final formData = FormData.fromMap({
        'inbody': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType('file', file.path.split('.').last),
        ),
      });
      var data = await apiService.sendFormData(
        endpoint: "api/v1/clients/${tokenModel.id}",
        token: tokenModel.accessToken,
        refreshToken: tokenModel.refreshToken,
        formData: formData,
      );
      var response = UpdateResponse.fromJson(data);
      UserRepository.setUser(response.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }*/
}
