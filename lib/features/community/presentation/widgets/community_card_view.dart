import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../contestants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_image_view.dart';
import 'community_details.dart';

class CommunityCardView extends StatelessWidget {
  const CommunityCardView({super.key, this.onPostsTap});

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
            imagePath: AssetsApp.backgroundCommunity,
            fit: BoxFit.cover,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                CustomImageView(
                  imagePath: kUserImage,
                  width: 85.r,
                  height: 85.r,
                  circle: true,
                ),
                10.heightBox,
                "Flutter Gang".make(
                    style: Styles.font22w700
                        .copyWith(color: ColorsManager.textColor)),
                5.heightBox,
                "@flutter".make(
                    style: Styles.font14w400
                        .copyWith(color: ColorsManager.grayColor)),
                25.heightBox,
                // to show posts, followers, following and title
                CommunityDetails(
                  onPostsTap: onPostsTap,
                  onFollowersTap: () {
                    AppRouter.router.push(AppRouter.followers);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



