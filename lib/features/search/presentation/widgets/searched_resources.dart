import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/utils/app_router.dart';
import '../../../home/presentation/widgets/post_view.dart';

class SearchedResources extends StatelessWidget {
  const SearchedResources({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
      separatorBuilder: (context, index) => 15.heightBox,
      itemBuilder: (context, index) => InkWell(
        onTap: () => AppRouter.router.push(AppRouter.resourceDetails),
        child: PostView(id: index),
      ),
      itemCount: 5,
    );
  }
}
