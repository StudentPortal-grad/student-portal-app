import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../contestants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';

class UserSearchedView extends StatelessWidget {
  const UserSearchedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: kUserImage,
          width: 48.r,
          height: 48.r,
          circle: true,
        ),
        12.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Mina Zarif".make(style: Styles.font18w600),
            "@Mimo".make(
                style: Styles.font16w500.copyWith(
                    fontWeight: FontWeight.w400, color: ColorsManager.black53)),
          ],
        )
      ],
    );
  }
}
