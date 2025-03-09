import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/features/profile/presentation/widgets/profile_details.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_image_view.dart';

class ProfileCardView extends StatelessWidget {
  const ProfileCardView({super.key, this.onPostsTap});

  final Function()? onPostsTap;

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
          actionOnTap: () {
            print(UserRepository.user?.profilePicture);
          },
        ),

        // profile body
        Positioned(
          top: 118.h,
          left: 0,
          right: 0,
          child: Column(
            children: [
              CustomImageView(
                placeHolder: AssetsApp.userPlaceHolder,
                imagePath: UserRepository.user?.profilePicture ?? AssetsApp.userPlaceHolder,
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
              ProfileDetails(
                onPostsTap: onPostsTap,
                onFollowersTap: () {
                  AppRouter.router.push(AppRouter.followers);
                },
                onFollowingTap: () {
                  AppRouter.router.push(AppRouter.followings);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
