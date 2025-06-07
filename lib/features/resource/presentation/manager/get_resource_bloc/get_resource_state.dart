part of 'get_resource_bloc.dart';

@immutable
sealed class GetResourceState {}

final class GetResourceInitial extends GetResourceState {}

final class GetResourceLoading extends GetResourceState {}

final class GetResourceLoaded extends GetResourceState {
  final List<Resource> resources;

  GetResourceLoaded(this.resources);
}

final class GetResourceFailed extends GetResourceState {
  final String message;

  GetResourceFailed(this.message);
}
