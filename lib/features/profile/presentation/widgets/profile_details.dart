import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/repo/user_repository.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../auth/data/model/user_model/user.dart';
import 'follow_button.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    super.key,
    this.onFollow,
    this.isFollowing = false,
    this.onFollowersTap,
    this.onFollowingTap,
    this.onPostTap,
    this.user,
  });

  final User? user;
  final bool isFollowing;
  final Function()? onFollow;
  final Function()? onPostTap;
  final Function()? onFollowersTap;
  final Function()? onFollowingTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              _buildStatItem((user?.follower.length ?? 0).toString(), "Followers", onFollowersTap),
              _buildDivider(),
              _buildStatItem((user?.following.length ?? 0).toString(), "Following", onFollowingTap),
              if(user?.id != UserRepository.user?.id)
              FollowButton(
                onTap: onFollow,
                isFollowed: isFollowing,
              )
              else ...[
                _buildDivider(),
                _buildStatItem((user?.posts.length ?? 0).toString(), "Posts", onPostTap),
              ]
            ],
          ),
        ),
        20.heightBox,
        if (user?.university?.isNotEmpty ?? false)
          Row(
            children: [
              35.widthBox,
              Icon(Icons.person_rounded, color: ColorsManager.mainColorLight, size: 20.sp),
              3.widthBox,
              "Student at ${user?.university}".make(
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
