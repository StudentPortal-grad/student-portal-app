import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/home/data/model/post_model/reply.dart';
import '../../../../core/helpers/time_formatting_helper.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text.dart';
import 'user_post_view.dart';

class PostCommentsView extends StatelessWidget {
  const PostCommentsView({super.key, this.reply});

  final Reply? reply;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        5.heightBox,
        buildCommentView(),
      ],
    );
  }

  Widget buildCommentView({bool showDivider = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        UserPostView(
          uploader: reply?.creator?.uploader,
          createFromAgo: TimeHelper.instance.timeAgo(reply?.createdAt),
        ),
        10.heightBox,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            if (showDivider) ...[
              Container(
                width: 1,
                color: ColorsManager.lightGrayColor,
              ),
              Spacer(),
            ],
            SizedBox(
              width: 250.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: reply?.content ?? ''),
                  10.heightBox,
                  // ReactBar(removeShare: true),
                  // 10.heightBox,
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

 static Widget buildShimmerComment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        12.widthBox,
        Row(
          children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: ColorsManager.lightGrayColor,
              ),
            ),
            10.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 10.h,
                      width: 100.w,
                      color: Colors.white,
                    ),
                  ),
                  5.heightBox,
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 10.h,
                      width: 60.w,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        10.heightBox,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            SizedBox(
              width: 250.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    2,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 10.h,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                        )),
              ),
            ),
          ],
        ),
        10.heightBox,
      ],
    );
  }
}
