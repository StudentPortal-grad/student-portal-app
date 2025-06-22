import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:student_portal/core/errors/data/model/error_model.dart';

import 'package:student_portal/features/notification/data/model/notification.dart';

import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../../domain/repo/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final ApiService apiService;

  NotificationRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final response = await apiService.get(endpoint: ApiEndpoints.notifications);
      log('notifications :: $response');
      return Right(response['data']['notifications'].map<NotificationModel>((e) => NotificationModel.fromJson(e)).toList());
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }
}
