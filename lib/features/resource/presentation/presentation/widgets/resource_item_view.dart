import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/time_formatting_helper.dart';
import 'package:student_portal/features/resource/presentation/presentation/widgets/resource_react_bar.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../home/presentation/widgets/category_tag_view.dart';
import '../../../../home/presentation/widgets/pdf_post_view.dart';
import '../../../../home/presentation/widgets/user_post_view.dart';
import '../../data/model/resource.dart';

class ResourceItemView extends StatelessWidget {
  const ResourceItemView({super.key, this.detailsChildren, this.resource});

  final Resource? resource;
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
          UserPostView(uploader: resource?.uploader, createFromAgo: TimeHelper.instance.timeAgo(resource?.createdAt)),
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

          PdfPostView(
            title: resource?.originalFileName ?? '',
            url: resource?.fileUrl ?? '',
            size: resource?.fileSize,
          ),

          17.heightBox,
          // react bar
          ResourceReactBar(resource: resource),
          if (detailsChildren != null) ...[
            17.heightBox,
            ...detailsChildren!,
          ]
        ],
      ),
    );
  }
}
