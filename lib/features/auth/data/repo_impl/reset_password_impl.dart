import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../domain/repo/reset_password_repo.dart';
import '../dto/set_new_password_dto.dart';

class ResetPasswordImpl implements ResetPasswordRepo {
  final ApiService apiService;

  ResetPasswordImpl(this.apiService);

  @override
  Future<Either<Failure, bool>> setNewPassword(SetNewPasswordDto setNewPasswordDto) async {
    try {
      log(setNewPasswordDto.toJson().toString());
      var data = await apiService.post(
        endpoint: ApiEndpoints.resetPassword,
        data: setNewPasswordDto.toJson(),
      );
      // var response = ResetPasswordResponse.fromJson(data);
      // UserRepository.setUser(response.data);
      log("Update Response: ${data.toString()}");
      return Right(true);
    } on DioException catch (e) {
      log('error: ${e.response?.data}');
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
