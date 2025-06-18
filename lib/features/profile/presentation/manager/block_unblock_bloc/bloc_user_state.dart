part of 'bloc_user_bloc.dart';

@immutable
sealed class BlockUserState {}

final class UserInitial extends BlockUserState {}

final class BlockLoadingState extends BlockUserState {}

final class BlockSuccessState extends BlockUserState {
  final String message;

  BlockSuccessState(this.message);
}

final class BlockFailedState extends BlockUserState {
  final String message;

  BlockFailedState(this.message);
}

final class UnBlockLoadingState extends BlockUserState {}

final class UnBlockSuccessState extends BlockUserState {
  final String message;

  UnBlockSuccessState(this.message);
}

final class UnBlockFailedState extends BlockUserState {
  final String message;

  UnBlockFailedState(this.message);
}
