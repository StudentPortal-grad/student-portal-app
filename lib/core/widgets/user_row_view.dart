import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/contestants.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/utils/app_router.dart';

import '../../features/auth/data/model/user_model/user.dart';
import '../theming/colors.dart';
import '../theming/text_styles.dart';
import 'custom_image_view.dart';

class UserRowView extends StatelessWidget {
  const UserRowView(
      {super.key,
      this.onUnfollowTap,
      this.showRemoveIcon,
      this.imageSize,
      this.user});

  final Function(String id)? onUnfollowTap;
  final bool? showRemoveIcon;
  final double? imageSize;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.router.push(AppRouter.profile, extra: {'userId': user?.id});
      },
      child: Row(
        children: [
          CustomImageView(
            imagePath: user?.profilePicture,
            width: imageSize ?? 48.r,
            height: imageSize ?? 48.r,
            placeHolder: kUserPlaceHolder,
            circle: true,
          ),
          12.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user?.name ?? "Portal Student User",
                  style: Styles.font15w600
                      .copyWith(fontSize: 16.sp, color: ColorsManager.textColor)),
              if (user?.username != null)
                SizedBox(
                  width: 0.45.sw,
                  child: Text(
                    '@${user?.username}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.font14w400.copyWith(fontWeight: FontWeight.w400, color: ColorsManager.black53),
                  ),
                ),
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
      ),
    );
  }
}
