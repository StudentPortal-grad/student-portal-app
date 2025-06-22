import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/notification.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
}