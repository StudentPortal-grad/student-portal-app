import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../contestants.dart';
import '../theming/colors.dart';
import '../theming/text_styles.dart';
import 'custom_image_view.dart';

class UserRowView extends StatelessWidget {
  const UserRowView({super.key, this.onUnfollowTap, this.showRemoveIcon});

  final Function(String id)? onUnfollowTap;
  final bool? showRemoveIcon;

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
            "Mina Zarif".make(
                style: Styles.font15w600
                    .copyWith(fontSize: 16.sp, color: ColorsManager.textColor)),
            "@Mimo".make(
                style: Styles.font14w400.copyWith(
                    fontWeight: FontWeight.w400, color: ColorsManager.black53)),
          ],
        ),
        Spacer(),
        if (showRemoveIcon ?? false)
          GestureDetector(
            onTap: () => onUnfollowTap?.call("User ID"),
            child: "Unfollow".make(
              style: Styles.font14w500.copyWith(
                  fontSize: 12.sp,
                  color: Color(0xffB42318),
                  fontWeight: FontWeight.w600),
            ),
          )
      ],
    );
  }
}
