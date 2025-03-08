import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/repo/user_repository.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../domain/repo/verify_email_repo.dart';
import '../dto/signup_otp_dto.dart';
import '../model/user_model/user.dart';

class VerifyEmailRepoImpl implements VerifyEmailRepo {
  final ApiService apiService;

  VerifyEmailRepoImpl(this.apiService);

  @override
  Future<Either<Failure, bool>> verifyEmail(SignupOtpDto signupOtpDto) async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.verifyEmail,
        data: signupOtpDto.toJson(),
      );
      log("Verify Success");
      SecureStorage().writeSecureData(
        id: data['data']['user']['_id'],
        accessToken: data['data']['token'],
      );
      User user = User.fromJson(data['data']['user']);
      UserRepository.setUser(user);
      return Right(true);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
