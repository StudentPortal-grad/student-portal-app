import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';

import '../../../../core/errors/data/model/error_model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../domain/repo/verify_forget_password_repo.dart';

class VerifyForgetPasswordImpl implements VerifyPasswordRepo {
  final ApiService apiService;

  VerifyForgetPasswordImpl(this.apiService);

  @override
  Future<Either<Failure, String>> verifyForgetPassword(
      {required String pinCode, required String email}) async {
    try {
      var data = await apiService.patch(
        endpoint: ApiEndpoints.verifyForgetEmail(pinCode),
        data: {"email": email},
      );
      String? resetToken = data['data']['resetToken'];
      if (resetToken != null) {
        SecureStorage().writeResetTokenData(resetToken: resetToken);
      }

      return const Right('Success');
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
