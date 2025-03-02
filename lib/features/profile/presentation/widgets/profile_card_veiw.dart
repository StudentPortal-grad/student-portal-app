import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../contestants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_image_view.dart';

class ProfileCardView extends StatelessWidget {
  const ProfileCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // background image
        Container(
          width: 1.sw,
          height: 416.h,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(35.r)),
          ),
          child: CustomImageView(
            width: 1.sw,
            height: 160.h,
            imagePath: AssetsApp.backgroundProfile,
            fit: BoxFit.fill,
          ),
        ),

        // app bar
        CustomAppBar(
          backgroundColor: Colors.transparent,
          leadingIconColor: Colors.white,
          action: Icon(Icons.more_vert_rounded, color: Colors.white),
          actionOnTap: () {},
        ),

        // profile body
        Positioned(
          top: 118.h,
          left: 0,
          right: 0,
          child: Column(
            children: [
              CustomImageView(
                imagePath: kUserImage,
                width: 85.r,
                height: 85.r,
                circle: true,
              ),
              10.heightBox,
              "Mina Zarif".make(
                  style: Styles.font22w700
                      .copyWith(color: ColorsManager.textColor)),
              5.heightBox,
              "@Mina10".make(
                  style: Styles.font14w400
                      .copyWith(color: ColorsManager.grayColor)),
              25.heightBox,
              // to show posts, followers, following and title
              ProfileDetails(),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildStatItem("10", "Posts", () => print('Posts')),
            _buildDivider(),
            _buildStatItem("10", "Followers", () => print('Followers')),
            _buildDivider(),
            _buildStatItem("10", "Following", () => print('Following')),
          ],
        ),
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_rounded, color: ColorsManager.mainColorLight,size: 20.sp),
            3.widthBox,
            "Student at Damanhour University".make(
              style: Styles.font14w400.copyWith(color: ColorsManager.mainColorLight),
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

  Widget _buildStatItem(String count, String label, VoidCallback onTap) {
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
