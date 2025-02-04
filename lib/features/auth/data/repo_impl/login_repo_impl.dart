import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';
import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/repo/user_repository.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../domain/repo/login_repo.dart';
import '../dto/login_request/login_request.dart';
import '../model/login_response/login_response.dart';


class LoginRepoImpl implements LoginRepo {
  final ApiService apiService;

  LoginRepoImpl(this.apiService);

  @override
  Future<Either<Failure, LoginResponse>> login({
    required LoginRequest loginRequest,
  }) async {
    log('login');

    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.login,
        data: loginRequest.toJson(),
      );
      log('login success');
      SecureStorage().writeSecureData(
        id: data['data']['_id'],
        accessToken: data['data']['accessToken'],
        refreshToken: data['data']['refreshToken'],
      );
      var response = LoginResponse.fromJson(data);
      UserRepository.setUser(response.data);
      return Right(response);
    } on DioException catch (e) {
      log('login error: ${e.response?.data}');
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
