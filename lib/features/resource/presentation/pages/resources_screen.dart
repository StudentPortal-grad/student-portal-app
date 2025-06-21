import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/core/helpers/custom_toast.dart';
import 'package:student_portal/features/resource/presentation/manager/get_resource_bloc/get_resource_bloc.dart';

import '../../../../../core/errors/data/model/error_model.dart';
import '../../../../../core/errors/view/error_screen.dart';
import '../../../../../core/widgets/loading_screen.dart';
import '../widgets/resources_body_view.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetResourceBloc, GetResourceState>(
      listener: (context, state) {
        if(state is GetResourceLoaded) {
          if (state.message?.isNotEmpty ?? false) {
            CustomToast(context).showSuccessToast(message: state.message!);
          }
        }
      },
      builder: (context, state) {
        if (state is GetResourceLoading) {
          return Center(
            child: LoadingScreen(useMainColors: true),
          );
        }
        if (state is GetResourceFailed) {
          return ErrorScreen(
            failure: Failure(message: state.message),
            onRetry: () async => BlocProvider.of<GetResourceBloc>(context).add(GetResourceEventRequested()),
          );
        }
        if (state is GetResourceLoaded) {
          return ResourcesBodyView(resources: state.resources);
        }
        return SizedBox.shrink();
      },
    );
  }
}


