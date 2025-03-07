import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/errors/data/model/error_model/error_model.dart';
import 'package:student_portal/features/auth/data/model/user_model/user.dart';
import 'package:student_portal/features/profile/domain/repo/get_my_profile_repo.dart';

import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/repo/user_repository.dart';

class GetMyProfileImpl implements GetMyProfileRepo {
  final ApiService apiService;

  GetMyProfileImpl(this.apiService);

  @override
  Future<Either<Failure, User>> getMyProfile() async {
    try {
      var data = await apiService.get(endpoint: ApiEndpoints.myProfile);
      log(data.toString());
      User user = User.fromJson(data['data']['user']);
      UserRepository.setUser(user);
      return Right(user);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
