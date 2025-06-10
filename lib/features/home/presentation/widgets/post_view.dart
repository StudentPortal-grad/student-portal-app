import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/widgets/app_text.dart';
import 'package:student_portal/features/home/data/model/post_model/post.dart';
import 'package:student_portal/features/home/presentation/widgets/post_list_images_view.dart';
import 'package:student_portal/features/home/presentation/widgets/react_bar.dart';
import 'package:student_portal/features/home/presentation/widgets/user_post_view.dart';

import '../../../../core/helpers/time_formatting_helper.dart';

class PostView extends StatelessWidget {
  const PostView({super.key, this.detailsChildren, this.discussion});

  final Discussion? discussion;
  final List<Widget>? detailsChildren;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 7,
            blurStyle: BlurStyle.outer,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      padding: EdgeInsets.all(18.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserPostView(
            uploader: discussion?.uploader,
            createFromAgo: TimeHelper.instance.timeAgo(discussion?.createdAt),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              21.heightBox,
              Text(discussion?.title ?? '', style: Styles.font14w700),
              10.heightBox,
              AppText(
                onHashTagTap: (p0) {
                  debugPrint('HASH TAG');
                  debugPrint(p0);
                },
                onMentionTap: (p0) {
                  debugPrint('on Mention');
                  debugPrint(p0);
                },
                text: discussion?.content ?? '',
                style: Styles.font12w400
                    .copyWith(color: ColorsManager.grayColor, height: 1.9),
              ),
              15.heightBox,
            ],
          ),
          PostListImagesView(attachments: discussion?.attachments ?? []),
          15.heightBox,
          // react bar
          ReactBar(),
          if (detailsChildren != null) ...[
            17.heightBox,
            ...detailsChildren!,
          ]
        ],
      ),
    );
  }
}
// tags layout

// Wrap(
//   spacing: 7.w,
//   runSpacing: 7.h,
//   children: List.generate(
//     discussion.tags.length,
//         (index) =>
//         CategoryTagView(
//           index: index,
//           title:  discussion.tags[index],
//         ),
//   ),
// ),
// 20.heightBox,
