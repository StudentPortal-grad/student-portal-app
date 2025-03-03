import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import 'join_button.dart';

class CommunityDetails extends StatelessWidget {
  const CommunityDetails({
    super.key,
    this.onPostsTap,
    this.onFollowersTap,
  });

  final Function()? onPostsTap;
  final Function()? onFollowersTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildStatItem("10", "Posts", onPostsTap),
            _buildDivider(),
            _buildStatItem("10", "Followers", onFollowersTap),
            Expanded(child: JoinButton()),
          ],
        ),
        20.heightBox,
        // Row(
        //   // mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     35.widthBox,
        //     Icon(Icons.person_rounded,
        //         color: ColorsManager.mainColorLight, size: 20.sp),
        //     3.widthBox,
        //     "Student at Damanhour University".make(
        //       style: Styles.font14w400
        //           .copyWith(color: ColorsManager.mainColorLight),
        //     ),
        //   ],
        // ),
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
