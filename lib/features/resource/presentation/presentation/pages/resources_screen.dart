import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/resource/presentation/presentation/manager/get_resource_bloc/get_resource_bloc.dart';

import '../../../../../core/errors/data/model/error_model.dart';
import '../../../../../core/errors/view/error_screen.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/custom_refresh_indicator.dart';
import '../../../../../core/widgets/loading_screen.dart';
import '../../data/model/resource.dart';
import '../widgets/resource_item_view.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetResourceBloc, GetResourceState>(
      builder: (context, state) {
        if (state is GetResourceLoading) {
          return Center(
            child: LoadingScreen(
              highlightColor: ColorsManager.mainColor,
              baseColor: ColorsManager.mainColorLight,
            ),
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

class ResourcesBodyView extends StatelessWidget {
  const ResourcesBodyView({super.key, this.resources = const []});

  final List<Resource> resources;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomRefreshIndicator(
        onRefresh: () async => context.read<GetResourceBloc>().add(GetResourceEventRequested()),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
          separatorBuilder: (context, index) => 15.heightBox,
          itemBuilder: (context, index) => InkWell(
            // onTap: () => AppRouter.router.push(AppRouter.resourceDetails),
            child: ResourceItemView(resource: resources[index]),
          ),
          itemCount: resources.length,
        ),
      ),
    );
  }
}
