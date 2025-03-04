import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/repo/user_repository.dart';
import '../../domain/repo/reset_password_repo.dart';
import '../model/reset_password_response/reset_password_response.dart';

class ResetPasswordImpl implements ResetPasswordRepo {
  final ApiService apiService;

  ResetPasswordImpl(this.apiService);

  @override
  Future<Either<Failure, ResetPasswordResponse>> setNewPassword(
      {required String resetToken, required String password}) async {
    try {
      var data = await apiService.patch(
        endpoint: ApiEndpoints.resetPassword,
        data: {
          "token": resetToken,
          "password": password,
        },
      );
      var response = ResetPasswordResponse.fromJson(data);
      UserRepository.setUser(response.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
