import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';

class TopicItemView extends StatelessWidget {
  const TopicItemView({
    super.key,
    this.selected = true,
    required this.topicName,
    this.onTap,
  });

  final bool selected;
  final String topicName;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(topicName),
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: topicName.make(
            style: Styles.font16w700.copyWith(
                color: selected ? ColorsManager.mainColor : Colors.white)),
      ),
    );
  }
}
