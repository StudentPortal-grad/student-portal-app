import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';

class AboutEventCard extends StatelessWidget {
  const AboutEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "About Event".make(
            style: Styles.font15w600,
          ),
          10.heightBox,
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo."
              .make(
            style: Styles.font12w400.copyWith(color: ColorsManager.grayColor),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
