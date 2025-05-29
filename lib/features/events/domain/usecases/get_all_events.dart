import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';

import '../../data/models/event_model.dart';
import '../repositories/events_repository.dart';

class GetAllEventsUC {
  final EventsRepository repository;

  GetAllEventsUC(this.repository);

  Future<Either<Failure,List<Event>>> call() async {
    return await repository.getAllEvents();
  }
} 