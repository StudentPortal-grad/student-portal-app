import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../data/model/resource.dart';
import '../../../domain/repo/resource_repository.dart';
import '../../../domain/usecases/get_all_resources.dart';

part 'get_resource_event.dart';

part 'get_resource_state.dart';

class GetResourceBloc extends Bloc<GetResourceEvent, GetResourceState> {
  GetResourceBloc() : super(GetResourceInitial()) {
    on<GetResourceEventRequested>(_onInitialLoad);
    on<GetResourceEventLoadMore>(_onLoadMore);
  }

  final GetAllResourcesUc getAllResourcesUc =
  GetAllResourcesUc(getIt<ResourceRepository>());

  final List<Resource> _resources = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  Future<void> _onInitialLoad(
      GetResourceEventRequested event, Emitter<GetResourceState> emit) async {
    _currentPage = 1;
    _hasMore = true;
    _resources.clear();

    if (!event.noLoading) emit(GetResourceLoading());

    final result = await getAllResourcesUc.call(page: _currentPage);
    result.fold(
          (failure) => emit(GetResourceFailed(failure.message ?? "Something went wrong")),
          (newResources) {
        _resources.addAll(newResources);
        _hasMore = newResources.isNotEmpty;
        emit(GetResourceLoaded(List.from(_resources), hasMore: _hasMore));
      },
    );
  }

  Future<void> _onLoadMore(
      GetResourceEventLoadMore event, Emitter<GetResourceState> emit) async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    _currentPage++;

    final result = await getAllResourcesUc.call(page: _currentPage);
    result.fold(
          (failure) {
        _currentPage--;
        emit(GetResourceFailed(failure.message ?? "Pagination Failed"));
      },
          (newResources) {
        if (newResources.isEmpty) {
          _hasMore = false;
        } else {
          _resources.addAll(newResources);
        }
        emit(GetResourceLoaded(List.from(_resources), hasMore: _hasMore));
      },
    );
    _isLoadingMore = false;
  }
}
