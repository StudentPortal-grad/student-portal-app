part of 'bloc_user_bloc.dart';

@immutable
sealed class BlockUserEvent {}

final class BlockUserEventRequest extends BlockUserEvent {
  final String userId;

  BlockUserEventRequest(this.userId);
}

final class UnBlockUserEventRequest extends BlockUserEvent {
  final String userId;

  UnBlockUserEventRequest(this.userId);
}
