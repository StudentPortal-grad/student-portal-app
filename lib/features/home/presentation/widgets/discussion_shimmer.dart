import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/home/presentation/widgets/post_comments_view.dart';

class DiscussionShimmer extends StatelessWidget {
  const DiscussionShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 7,
            blurStyle: BlurStyle.outer,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
      margin: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 20.r, backgroundColor: Colors.grey[300]),
                10.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 12.h, width: 100.w, color: Colors.grey[300]),
                    5.heightBox,
                    Container(
                        height: 10.h, width: 60.w, color: Colors.grey[300]),
                  ],
                ),
              ],
            ),
            21.heightBox,
            Container(height: 14.h, width: 200.w, color: Colors.grey[300]),
            10.heightBox,

            // 5.heightBox,
            Container(
                height: 12.h, width: double.infinity, color: Colors.grey[300]),
            5.heightBox,
            Container(
                height: 12.h,
                width: MediaQuery.of(context).size.width * 0.7,
                color: Colors.grey[300]),
            15.heightBox,
            Container(
                height: 120.h, width: double.infinity, color: Colors.grey[300]),
            30.heightBox,
            ...List.generate(
                3, (index) => PostCommentsView.buildShimmerComment()),
          ],
        ),
      ),
    );
  }
}
