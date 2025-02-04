import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../domain/repo/forget_password_repo.dart';
import '../model/forget_password_response/forget_password_response.dart';

class ForgetPasswordImpl implements ForgetPasswordRepo {
  final ApiService apiService;

  ForgetPasswordImpl(this.apiService);

  @override
  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword(
      {required String email}) async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.forgetPassword,
        data: {"email": email},
      );
      return Right(ForgetPasswordResponse.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
