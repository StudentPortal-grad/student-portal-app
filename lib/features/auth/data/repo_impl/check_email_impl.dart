import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_endpoints.dart';
import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_service.dart';
import '../../domain/repo/check_email_repo.dart';
import '../model/check_email_response/check_email_response.dart';

class CheckEmailRepoImpl implements CheckEmailRepo {
  final ApiService apiService;

  CheckEmailRepoImpl(this.apiService);

  @override
  Future<Either<Failure, CheckEmailResponse>> checkEmail({
    required String email,
  }) async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.checkEmail,
        data: {
          "email": email,
        },
      );
      return Right(CheckEmailResponse.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
