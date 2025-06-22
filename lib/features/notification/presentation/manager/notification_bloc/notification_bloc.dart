import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/notification/domain/repo/notification_repo.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../data/model/notification.dart';
import '../../../domain/usecases/get_notifications_us.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<GetNotificationsEvent>(_getNotificationsEvent);
  }

  final GetNotificationsUs _getNotificationsUs = GetNotificationsUs(getIt<NotificationRepo>());

Future<void> _getNotificationsEvent (GetNotificationsEvent event,Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    final result = await _getNotificationsUs.call();
    result.fold(
      (error) => emit(NotificationFailed(error.message ?? 'Something went wrong')),
      (response) => emit(NotificationLoaded(response)),
    );
  }
}
