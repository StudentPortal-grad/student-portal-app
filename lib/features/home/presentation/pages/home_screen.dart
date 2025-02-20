import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/utils/app_router.dart';
import '../widgets/post_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
        separatorBuilder: (context, index) => 15.heightBox,
        itemBuilder: (context, index) => InkWell(
          onTap: () => AppRouter.router.push(AppRouter.postDetails),
          child: PostView(id: index),
        ),
        itemCount: 2,
      ),
    );
  }
}
