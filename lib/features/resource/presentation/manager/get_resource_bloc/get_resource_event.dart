part of 'get_resource_bloc.dart';

@immutable
sealed class GetResourceEvent {}

class GetResourceEventRequested extends GetResourceEvent {
  final bool noLoading;

  GetResourceEventRequested({this.noLoading = false});
}

class GetResourceEventLoadMore extends GetResourceEvent {}