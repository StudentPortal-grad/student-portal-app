import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/repo/user_repository.dart';
import '../../domain/repo/signup_repo.dart';
import '../dto/signup_request.dart';
import '../model/signup_response/signup_response.dart';


class SignupRepoImpl implements SignupRepo {
  final ApiService apiService;

  SignupRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SignupResponse>> signup(
      {required SignupRequest signupRequest}) async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.signup,
        data: signupRequest.toJson(),
      );
      var response = SignupResponse.fromJson(data);
      UserRepository.setUser(response.data);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
