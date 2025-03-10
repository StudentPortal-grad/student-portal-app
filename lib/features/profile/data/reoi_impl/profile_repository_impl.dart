import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/features/profile/data/dto/update_profile_dto.dart';
import 'package:student_portal/features/profile/domain/repo/profile_repository.dart';

import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/repo/user_repository.dart';
import '../../../auth/data/model/user_model/user.dart';
import '../dto/change_password_dto.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiService apiService;

  ProfileRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, User>> getMyProfile() async {
    try {
      var data = await apiService.get(
        endpoint: ApiEndpoints.myProfile);
      log(data.toString());
      User user = User.fromJson(data['data']['user']);
      UserRepository.setUser(user);
      return Right(user);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, User>> getUserProfile({required String userId}) async {
    try {
      var data =
          await apiService.get(endpoint: ApiEndpoints.getUserProfile(userId));
      log(data.toString());
      return Right(User.fromJson(data['data']['user']));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile(
      {required UpdateProfileDto updateProfileDto}) async {
    try {
      log(updateProfileDto.toJson().toString());
      var data = await apiService.patch(
        endpoint: ApiEndpoints.myProfile,
        formData: await updateProfileDto.toFormData(),
      );
      log(data.toString());
      User user = User.fromJson(data['data']['user']);
      UserRepository.setUser(user);
      return Right(user);
    } on DioException catch (e) {
      log(e.toString());
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword({required ChangePasswordDto changePasswordDto})async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.changePassword,
        data: changePasswordDto.toJson(),
      );
      return Right(data['message'] ?? '');
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
