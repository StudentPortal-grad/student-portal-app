import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:student_portal/core/errors/data/model/error_model.dart';

import 'package:student_portal/features/auth/data/dto/complete_dto.dart';

import 'package:student_portal/features/auth/data/dto/login_dto.dart';

import 'package:student_portal/features/auth/data/dto/otp_dto.dart';

import 'package:student_portal/features/auth/data/dto/set_new_password_dto.dart';

import 'package:student_portal/features/auth/data/dto/signup_otp_dto.dart';

import 'package:student_portal/features/auth/data/dto/signup_request.dart';

import 'package:student_portal/features/auth/data/model/check_email_response/check_email_response.dart';

import 'package:student_portal/features/auth/data/model/signup_response/signup_response.dart';

import 'package:student_portal/features/auth/data/model/update_response/update_response.dart';

import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/repo/user_repository.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../../../core/utils/service_locator.dart';
import '../../domain/repo/auth_repo.dart';
import '../model/token_model/token_model.dart';
import '../model/user_model/user.dart';

class AuthRepoImpl implements AuthRepository {
  final ApiService apiService;
  final secureStorage = getIt<SecureStorage>();

  AuthRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, String>> forgetPassword(
      {required String email}) async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.forgetPassword,
        data: {"email": email},
      );
      return Right(data['data']['message']);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> login({required LoginDTO loginRequest}) async {
    log('login');
    log(loginRequest.toJson().toString());
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.login,
        data: loginRequest.toJson(),
      );
      log('login success');
      log(data.toString());
      secureStorage.writeSecureData(
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

  @override
  Future<Either<Failure, CheckEmailResponse>> resendVerification(
      {required String email}) async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.resendVerification,
        data: {
          "email": email,
        },
      );
      return Right(CheckEmailResponse.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> setNewPassword(
      SetNewPasswordDto setNewPasswordDTO) async {
    try {
      log(setNewPasswordDTO.toJson().toString());
      var data = await apiService.post(
        endpoint: ApiEndpoints.resetPassword,
        data: setNewPasswordDTO.toJson(),
      );
      log("Update Response: ${data.toString()}");
      return Right(true);
    } on DioException catch (e) {
      log('error: ${e.response?.data}');
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, SignupResponse>> signup(
      {required SignupDTO signupRequest}) async {
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

  @override
  Future<Either<Failure, UpdateResponse>> completeProfile(
      CompleteDto completeDto) async {
    try {
      log("update DTO: ${completeDto.toJson().toString()}");
      TokenModel? tokenModel = await secureStorage.readSecureData();
      if (tokenModel == null) {
        return Left(ServerFailure(message: "Token not found"));
      }

      var data = await apiService.post(
        endpoint: ApiEndpoints.completeProfile,
        formData: await completeDto.toFormData(),
        token: tokenModel.accessToken,
      );
      var response = UpdateResponse.fromJson(data);
      UserRepository.setUser(response.data);
      log("Update Response: $data");
      return Right(response);
    } on DioException catch (e) {
      log((e.toString()));
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyEmail(SignupOtpDto signupOtpDto) async {
    try {
      var data = await apiService.post(
        endpoint: ApiEndpoints.verifyEmail,
        data: signupOtpDto.toJson(),
      );
      log("Verify Success");
      secureStorage.writeSecureData(
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

  @override
  Future<Either<Failure, String>> verifyForgetPassword(OtpDto otpDTO) async {
    try {
      log(otpDTO.toJson().toString());
      var data = await apiService.post(
        endpoint: ApiEndpoints.verifyOtp,
        data: otpDTO.toJson(),
      );
      String? resetToken = data['data']['resetToken'];
      if (resetToken != null) {
        secureStorage.writeResetTokenData(resetToken: resetToken);
      }
      return const Right('Success');
    } on DioException catch (e) {
      log('error: ${e.response?.data}');
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async{
    try {
      TokenModel? tokenModel = await secureStorage.readSecureData();
      if (tokenModel == null) {
        return Left(ServerFailure(message: "Token not found"));
      }
      var data = await apiService.post(
        endpoint: ApiEndpoints.logout,
        token: tokenModel.accessToken,
      );
      UserRepository.removeUser();
      return Right(data['message']);
    } on DioException catch (e) {
      log((e.toString()));
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
