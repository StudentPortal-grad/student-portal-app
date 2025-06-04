import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/event_rsvp.dart';
import '../repositories/events_repository.dart';

class BookLeaveEventSeatUs {
  final EventsRepository repository;

  BookLeaveEventSeatUs(this.repository);

  Future<Either<Failure, String>> call(EventRsvpDTO eventRsvpDTO) async {
    return await repository.updateEventRSVP(eventRsvpDTO);
  }
}
