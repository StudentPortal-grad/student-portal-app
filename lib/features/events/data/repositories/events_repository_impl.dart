import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../domain/repositories/events_repository.dart';
import '../models/event_model.dart';

class EventsRepositoryImpl implements EventsRepository {
  @override
  Future<Either<Failure, List<Event>>> getAllEvents() {
    // TODO: implement getAllEvents
    throw UnimplementedError();
  }

  @override
  Future<Either<Future, Event>> getEventById(String id) {
    // TODO: implement getEventById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> joinEvent(String eventId) {
    // TODO: implement joinEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> leaveEvent(String eventId) {
    // TODO: implement leaveEvent
    throw UnimplementedError();
  }
}
