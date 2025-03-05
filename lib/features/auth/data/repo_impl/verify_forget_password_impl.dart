import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../domain/repo/verify_forget_password_repo.dart';
import '../dto/otp_dto.dart';

class VerifyForgetPasswordImpl implements VerifyPasswordRepo {
  final ApiService apiService;

  VerifyForgetPasswordImpl(this.apiService);

  @override
  Future<Either<Failure, String>> verifyForgetPassword(OtpDto otpDto) async {
    try {
      log(otpDto.toJson().toString());
      var data = await apiService.post(
        endpoint: ApiEndpoints.verifyOtp,
        data: otpDto.toJson(),
      );
      String? resetToken = data['data']['resetToken'];
      if (resetToken != null) {
        SecureStorage().writeResetTokenData(resetToken: resetToken);
      }
      return const Right('Success');
    } on DioException catch (e) {
      log('error: ${e.response?.data}');
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
