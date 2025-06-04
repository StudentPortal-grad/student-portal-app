import 'package:dartz/dartz.dart';
import 'package:student_portal/features/events/domain/repositories/events_repository.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/models/event_model.dart';

class GetEventDetails {
  final EventsRepository repository;

  GetEventDetails(this.repository);

  Future<Either<Failure, Event>> call(String eventId) async {
    return await repository.getEventById(eventId);
  }
}
