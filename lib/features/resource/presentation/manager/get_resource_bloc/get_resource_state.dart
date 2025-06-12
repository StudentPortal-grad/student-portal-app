part of 'get_resource_bloc.dart';

@immutable
sealed class GetResourceState {}

final class GetResourceInitial extends GetResourceState {}

class GetResourceLoading extends GetResourceState {}

class GetResourceLoaded extends GetResourceState {
  final List<Resource> resources;
  final bool hasMore;
  final String? message;

  GetResourceLoaded(this.resources, {this.message, this.hasMore = true});
}

class GetResourceFailed extends GetResourceState {
  final String message;

  GetResourceFailed(this.message);
}
