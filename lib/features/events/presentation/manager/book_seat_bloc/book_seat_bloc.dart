import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/events/data/dto/event_rsvp.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../domain/repositories/events_repository.dart';
import '../../../domain/usecases/book_leave_event_seat_us.dart';

part 'book_seat_event.dart';

part 'book_seat_state.dart';

class BookSeatBloc extends Bloc<BookSeatEvent, BookSeatState> {
  BookSeatBloc() : super(BookSeatInitial()) {
    on<BookSeatRequested>(_onBookSeatRequested);
  }

  final BookLeaveEventSeatUs bookLeaveEventSeatUs =
      BookLeaveEventSeatUs(getIt.get<EventsRepository>());

  Future<void> _onBookSeatRequested(
      BookSeatRequested event, Emitter<BookSeatState> emit) async {
    emit(BookSeatLoading());
    var data = await bookLeaveEventSeatUs.call(event.eventRsvpDTO);
    data.fold(
      (error) => emit(BookSeatFailed(error.message ?? 'Unknown error')),
      (response) => emit(BookSeatLoaded(response)),
    );
  }
}
