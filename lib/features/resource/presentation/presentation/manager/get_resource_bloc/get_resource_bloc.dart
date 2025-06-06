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
    on<GetResourceEventRequested>(_getResourceRequest);
  }

  final GetAllResourcesUc getAllResourcesUc =
      GetAllResourcesUc(getIt<ResourceRepository>());

  Future<void> _getResourceRequest(
      GetResourceEventRequested event, Emitter<GetResourceState> emit) async {
    if (!event.noLoading) emit(GetResourceLoading());
    final result = await getAllResourcesUc.call();
    result.fold(
      (failure) => emit(GetResourceFailed(failure.message ?? "Something went wrong")),
      (resources) => emit(GetResourceLoaded(resources)),
    );
  }
}
