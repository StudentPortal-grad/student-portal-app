import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/home/data/model/post_model/post.dart';
import 'package:student_portal/features/resource/data/model/resource.dart';

import '../../../../contestants.dart';
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
        UserPostView(uploader: Uploader(profilePicture: kUserImage, name: 'John Doe'), createFromAgo: TimeHelper.instance.timeAgo(reply?.createdAt),),
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
                  AppText(
                    text: reply?.content ?? ''
                  ),
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
}
