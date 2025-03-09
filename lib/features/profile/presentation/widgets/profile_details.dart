import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../auth/data/model/user_model/user.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    super.key,
    this.onPostsTap,
    this.onFollowersTap,
    this.onFollowingTap,
    this.user,
  });

  final User? user;
  final Function()? onPostsTap;
  final Function()? onFollowersTap;
  final Function()? onFollowingTap;

  @override
  Widget build(BuildContext context) {
    // return CustomLoadingIndicator();
    return Column(
      children: [
        Row(
          children: [
            _buildStatItem("0", "Posts", onPostsTap),
            _buildDivider(),
            _buildStatItem("0", "Followers", onFollowersTap),
            _buildDivider(),
            _buildStatItem("0", "Following", onFollowingTap),
          ],
        ),
        20.heightBox,
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            35.widthBox,
            Icon(Icons.person_rounded,
                color: ColorsManager.mainColorLight, size: 20.sp),
            3.widthBox,
            "Student at Damanhour University".make(
              style: Styles.font14w400.copyWith(
                color: ColorsManager.mainColorLight,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() => Container(
        height: 32.h,
        width: 1,
        color: Color(0xffdddddd),
      );

  Widget _buildStatItem(String count, String label, VoidCallback? onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Text(count,
                style:
                    Styles.font20w600.copyWith(color: ColorsManager.textColor)),
            Text(label,
                style:
                    Styles.font14w400.copyWith(color: ColorsManager.grayColor)),
          ],
        ),
      ),
    );
  }
}
