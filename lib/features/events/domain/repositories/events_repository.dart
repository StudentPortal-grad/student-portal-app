import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/models/event_model.dart';

abstract class EventsRepository {
  Future<Either<Failure, List<Event>>> getAllEvents();

  Future<Either<Failure, Event>> getEventById(String id);

  Future<Either<Failure, String>> joinEvent(String eventId);

  Future<Either<Failure, String>> leaveEvent(String eventId);
}
