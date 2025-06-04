part of 'book_seat_bloc.dart';

@immutable
sealed class BookSeatEvent {}

class BookSeatRequested extends BookSeatEvent {
  final EventRsvpDTO eventRsvpDTO;

  BookSeatRequested(this.eventRsvpDTO);
}
