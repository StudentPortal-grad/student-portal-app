part of 'book_seat_bloc.dart';

@immutable
sealed class BookSeatState {}

final class BookSeatInitial extends BookSeatState {}

final class BookSeatLoading extends BookSeatState {}

final class BookSeatLoaded extends BookSeatState {
  final String message;

  BookSeatLoaded(this.message);
}

final class BookSeatFailed extends BookSeatState {
  final String message;

  BookSeatFailed(this.message);
}
