import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/features/resource/domain/entities/resource_entity.dart';
import 'package:student_portal/features/resource/presentation/widgets/resource_item_view.dart';

import '../../../../core/utils/app_router.dart';

class ProfileResourcesView extends StatelessWidget {
  const ProfileResourcesView({super.key, this.resources = const []});

  final List<ResourceEntity> resources;

  @override
  Widget build(BuildContext context) {
    if(resources.isEmpty) {
      return Padding(padding: EdgeInsets.symmetric(vertical: 0.25.sh),child: "There's no resources".make());
    }
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
      separatorBuilder: (context, index) => 15.heightBox,
      itemBuilder: (context, index) => InkWell(
        onTap: () => AppRouter.router.push(AppRouter.resourceDetails, extra: {'resource': resources[index]}),
        child: ResourceItemView(
          navToDetails: false,
          resource: resources[index],
        ),
      ),
      itemCount: resources.length,
    );
  }
}
