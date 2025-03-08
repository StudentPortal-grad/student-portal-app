// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/repo/user_repository.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../domain/repo/update_data_repo.dart';
import '../dto/complete_dto.dart';
import '../model/token_model/token_model.dart';
import '../model/update_response/update_response.dart';

class UpdateDataImpl implements UpdateDataRepo {
  final ApiService apiService;

  UpdateDataImpl(this.apiService);

  @override
  Future<Either<Failure, UpdateResponse>> update(
      CompleteDto completeDto) async {
    try {
      log("update DTO: ${completeDto.toJson().toString()}");
      TokenModel? tokenModel = await SecureStorage().readSecureData();
      if (tokenModel == null) {
        return Left(ServerFailure(message: "Token not found"));
      }

      var data = await apiService.post(
        endpoint: ApiEndpoints.completeProfile,
        formData: await completeDto.toFormData(),
        token: tokenModel.accessToken,
      );
      var response = UpdateResponse.fromJson(data);
      UserRepository.setUser(response.data);
      log("Update Response: $data");
      return Right(response);
    } on DioException catch (e) {
      log((e.toString()));
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
