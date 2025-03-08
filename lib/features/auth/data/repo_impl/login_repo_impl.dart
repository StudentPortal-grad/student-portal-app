import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';
import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/repo/user_repository.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../domain/repo/login_repo.dart';
import '../dto/login_dto.dart';
import '../model/user_model/user.dart';


class LoginRepoImpl implements LoginRepo {
  final ApiService apiService;

  LoginRepoImpl(this.apiService);

  @override
  Future<Either<Failure, bool>> login({
    required LoginDTO loginRequest,
  }) async {
    log('login');
    log(loginRequest.toJson().toString());
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.login,
        data: loginRequest.toJson(),
      );
      log('login success');
      SecureStorage().writeSecureData(
        id: data['data']['user']['_id'],
        accessToken: data['data']['token'],
      );
      User user = User.fromJson(data['data']['user']);
      UserRepository.setUser(user);
      return Right(true);
    } on DioException catch (e) {
      log('login error: ${e.response?.data}');
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
