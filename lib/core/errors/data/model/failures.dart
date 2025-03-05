import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:student_portal/core/errors/data/model/error_model/error_model.dart';
import 'package:student_portal/core/utils/app_router.dart';

import '../../../helpers/app_dialog.dart';
import '../../../repo/user_repository.dart';
import '../../../utils/secure_storage.dart';

class ServerFailure extends Failure {
  const ServerFailure({
    super.message,
    super.success,
  });

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
          message: "Connection Timeout",
        );
      case DioExceptionType.sendTimeout:
        return const ServerFailure(message: "Send Timeout");
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: "Receive Timeout");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          statusCode: dioError.response!.statusCode!,
          response: dioError.response!.data!,
        );
      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Request to ApiServer was canceled');
      case DioExceptionType.connectionError:
        return const ServerFailure(message: "Connection Error");
      case DioExceptionType.unknown:
        return ServerFailure(message: dioError.message);
      default:
        return ServerFailure(message: dioError.message);
    }
  }

  factory ServerFailure.fromResponse(
      {required int? statusCode, required dynamic response}) {
    log("Error Response: ${response.toString()}");
    isTokenExpired(response);
    emailNotActive(response);
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 404 ||
        statusCode == 500 ||
        statusCode == 409 ||
        statusCode == 300) {
      return ServerFailure(
        message: response['message'],
        // error: response['error'],
        // status: response['status'],
        // args: response['args'] ?? {},
      );
    } else {
      return const ServerFailure(
        message: 'Oops, Unexpected error occurred, Please try again later',
      );
    }
  }

  static isTokenExpired(dynamic response) {
    // todo// check it with backend
    try {
      final msg = response is Map ? (response['name'] ?? "") : '';
      if (msg == 'TOKEN_EXPIRED' ||
          msg == 'TOKEN_NOT_FOUND' ||
          msg == 'ACCESS_TOKEN_EXPIRED' ||
          msg == "USER_NOT_FOUND") {
        log('Token has expired.');
        if (AppRouter.context != null) {
          log('AppRouter.context != null');
          AppDialogs.showErrorDialog(AppRouter.context!,
              dismissible: false,
              error: 'Token has expired please login again',
              canPop: false,
              okText: 'ok',
              onOkTap: () => AppRouter.clearAndNavigate(AppRouter.loginView));
        }
        SecureStorage().deleteSecureData();
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static emailNotActive(dynamic response) {
    try {
      final msg = response is Map ? (response['name'] ?? "") : '';
      if (msg == 'EMAIL_NOT_ACTIVE') {
        AppRouter.router.push(AppRouter.otpView, extra: {
          "email": UserRepository.user?.email ?? "",
          "isForgetPassword": false,
        });
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
