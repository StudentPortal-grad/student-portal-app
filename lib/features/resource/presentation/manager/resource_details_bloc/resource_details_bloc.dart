import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/home/data/dto/reply_dto.dart';

import '../../../data/model/resource.dart';

part 'resource_details_event.dart';

part 'resource_details_state.dart';

class ResourceDetailsBloc
    extends Bloc<ResourceDetailsEvent, ResourceDetailsState> {
  ResourceDetailsBloc(this.resource) : super(ResourceDetailsInitial()) {
    on<ResourceDetailsEvent>((event, emit) {});
  }

  Resource? resource;
}
