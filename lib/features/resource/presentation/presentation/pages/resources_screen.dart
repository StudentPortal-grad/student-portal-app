import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/resource/presentation/presentation/manager/get_resource_bloc/get_resource_bloc.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/widgets/custom_refresh_indicator.dart';
import '../../../../../core/widgets/loading_screen.dart';
import '../../../../home/presentation/widgets/post_view.dart';

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
          return CustomRefreshIndicator(
            onRefresh: () async => context.read<GetResourceBloc>().add(GetResourceEventRequested()),
            child: Center(
              child: Text(state.message),
            ),
          );
        }
        if(state is GetResourceLoaded) {
          return SafeArea(
          child: CustomRefreshIndicator(
            onRefresh: () async => context.read<GetResourceBloc>().add(GetResourceEventRequested()),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
              separatorBuilder: (context, index) => 15.heightBox,
              itemBuilder: (context, index) => InkWell(
                onTap: () => AppRouter.router.push(AppRouter.resourceDetails),
                child: PostView(id: index),
              ),
              itemCount: 2,
            ),
          ),
        );
        }
        return SizedBox.shrink();
      },
    );
  }
}
