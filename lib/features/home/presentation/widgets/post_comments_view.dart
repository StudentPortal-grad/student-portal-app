import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text.dart';
import 'react_bar.dart';
import 'user_post_view.dart';

class PostCommentsView extends StatelessWidget {
  const PostCommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildCommentView(showDivider: true),
        buildCommentView(),
      ],
    );
  }

  Widget buildCommentView({bool showDivider = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        UserPostView(),
        10.heightBox,
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              if (showDivider) ...[
                Container(
                  width: 1,
                  // height: double.infinity, // This makes it expand to available height
                  color: ColorsManager.lightGrayColor,
                ),
                Spacer(),
              ],
              SizedBox(
                width: 250.w,
                child: Column(
                  children: [
                    AppText(
                      text:
                      'These methods include quantitative techniques, such as statistical analysis and machine learning algorithms.',
                    ),
                    10.heightBox,
                    ReactBar(removeShare: true),
                    10.heightBox,
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}