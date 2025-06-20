
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({super.key, this.isFollowed = false, this.onTap});

  final bool isFollowed;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomAppButton(
      height: 35.h,
      width: isFollowed ? 120.w : 100.w,
      backgroundColor: isFollowed ? ColorsManager.greenColor : ColorsManager.mainColor,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 5.w),
      borderRadius: 20.r,
      label: isFollowed ? 'Following' : 'Follow',
      textStyle: Styles.font16w700.copyWith(color: Colors.white),
      onTap: onTap?.call() ?? () {},
      spacing: 5.w,
      prefixIcon: Icon(
          isFollowed ? Icons.check_rounded : Icons.person_add_alt_1_rounded,
          color: Colors.white,
          size: 18.r),
    );
  }
}