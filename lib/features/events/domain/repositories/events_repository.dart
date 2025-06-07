import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/event_rsvp.dart';
import '../../data/models/event_model.dart';

abstract class EventsRepository {
  Future<Either<Failure, List<Event>>> getAllEvents({int page = 1});

  Future<Either<Failure, Event>> getEventById(String id);

  Future<Either<Failure, String>> updateEventRSVP(EventRsvpDTO eventRsvpDTO);
}
