import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../domain/repo/verify_email_repo.dart';
import '../model/verify_response/verify_response.dart';

class VerifyEmailRepoImpl implements VerifyEmailRepo {
  final ApiService apiService;

  VerifyEmailRepoImpl(this.apiService);

  @override
  Future<Either<Failure, VerifyResponse>> verifyEmail(
      {required String pinCode, required String email}) async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.verifyEmail,
        data: {
          "email": email,
          "pinCode": pinCode
        },
      );
      log("Verify Success");
      SecureStorage().writeSecureData(
        id: data['data']['_id'],
        accessToken: data['data']['accessToken'],
        refreshToken: data['data']['refreshToken'],
      );
      return Right(VerifyResponse.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
