import 'package:dartz/dartz.dart';
import 'package:student_portal/features/notification/domain/repo/notification_repo.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/model/notification.dart';

class GetNotificationsUs {
  final NotificationRepo _notificationRepo;

  GetNotificationsUs(this._notificationRepo);

  Future<Either<Failure, List<NotificationModel>>> call() => _notificationRepo.getNotifications();
}
