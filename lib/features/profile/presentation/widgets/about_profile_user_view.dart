import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../auth/data/model/user_model/profile.dart';
import '../../../home/presentation/widgets/category_tag_view.dart';

class AboutProfileUserView extends StatelessWidget {
  const AboutProfileUserView({super.key, this.userProfile});

  final Profile? userProfile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          25.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "About Me".make(
                  style: Styles.font18w700.copyWith(
                color: ColorsManager.textColor,
              )),
              // if(myProfile)
              GestureDetector(
                onTap: () {
                  // push to edit profile screen
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.babyBlue,
                    backgroundBlendMode: BlendMode.srcATop,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                  child: Row(
                    children: [
                      "Edit".make(
                          style: Styles.font15w600.copyWith(
                              color: ColorsManager.mainColor, fontSize: 12.sp)),
                      5.widthBox,
                      CustomImageView(
                        imagePath: AssetsApp.editIcon,
                        color: ColorsManager.mainColor,
                        // size: 15.sp,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          10.heightBox,
          AppText(
            text: userProfile?.bio ?? '',
            style: Styles.font16w500.copyWith(
              fontWeight: FontWeight.w400,
              color: ColorsManager.textColor,
            ),
          ),
          if (userProfile?.interests?.isNotEmpty ?? false) ...[
            20.heightBox,
            "Interests".make(
              style: Styles.font18w700.copyWith(color: ColorsManager.textColor),
            ),
            10.heightBox,
            Wrap(
              spacing: 7.w,
              runSpacing: 7.h,
              children: List.generate(
                userProfile?.interests?.length ?? 0,
                (index) => CategoryTagView(
                  index: index,
                  title: userProfile?.interests?[index] ?? '',
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
