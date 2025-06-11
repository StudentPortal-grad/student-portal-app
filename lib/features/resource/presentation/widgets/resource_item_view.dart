import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/time_formatting_helper.dart';
import 'package:student_portal/features/resource/presentation/widgets/resource_react_bar.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../home/presentation/widgets/category_tag_view.dart';
import 'pdf_post_view.dart';
import '../../../home/presentation/widgets/user_post_view.dart';
import '../../data/model/resource.dart';

class ResourceItemView extends StatelessWidget {
  const ResourceItemView({super.key, this.detailsChildren, this.resource, this.onVoteTap});

  final Resource? resource;
  final List<Widget>? detailsChildren;
  final Function(String)? onVoteTap;

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
            uploader: resource?.uploader,
            createFromAgo: TimeHelper.instance.timeAgo(resource?.createdAt),
          ),
         if (resource?.tags?.isNotEmpty ?? false) ...[
            21.heightBox,
            Wrap(
              spacing: 7.w,
              runSpacing: 7.h,
              children: List.generate(
                resource?.tags?.length ?? 0,
                (index) => CategoryTagView(
                  index: index,
                  title: resource?.tags?[index] ?? '',
                ),
              ),
            ),
            20.heightBox,
          ],
          Text(resource?.title ?? '', style: Styles.font14w700),
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
            text: resource?.description ?? '',
            style: Styles.font12w400.copyWith(color: ColorsManager.grayColor, height: 1.9),
          ),
          20.heightBox,
          if (resource?.fileUrl != null && resource?.originalFileName != null)
            ListView.separated(
              itemBuilder: (context, index) => PdfPostView(
                title: resource?.originalFileName ?? '',
                url: resource?.fileUrl ?? '',
                size: resource?.fileSize,
              ),
              separatorBuilder: (context, index) => 10.heightBox,
              shrinkWrap: true,
              itemCount: 1,
              physics: NeverScrollableScrollPhysics(),
            ),
          17.heightBox,
          // react bar
          ResourceReactBar(
            currentVote: resource?.currentVote ?? 0,
            votes: resource?.upVotesCount ?? 0,
            comments: resource?.comments?.length ?? 0,
            onVoteTap: (p0) {
              log('onVoteTap $p0');
              onVoteTap?.call(p0);
            },
          ),
          if (detailsChildren != null) ...[
            17.heightBox,
            ...detailsChildren!,
          ]
        ],
      ),
    );
  }
}
