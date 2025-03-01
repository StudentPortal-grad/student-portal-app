import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../contestants.dart';
import '../../../../core/helpers/time_formatting_helper.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_image_view.dart';

class InvitationItemView extends StatelessWidget {
  const InvitationItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          circle: true,
          width: 48.r,
          height: 48.r,
          imagePath: kUserImage,
        ),
        12.widthBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  text:
                      "You have been added by *Alia* as an admin to the unofficial community *Flutter Gang*"),
              3.heightBox,
              TimeHelper.instance
                  .timeAgo(DateTime.now().subtract(Duration(minutes: 5)))
                  .make(
                    style: Styles.font14w500
                        .copyWith(color: ColorsManager.gray3, fontSize: 13.sp),
                  ),
              10.heightBox,
              Row(
                children: [
                  Expanded(
                    child: CustomAppButton(
                      backgroundColor: Colors.transparent,
                      borderColor: ColorsManager.lightGreyColor,
                      borderRadius: 15.r,
                      label: 'Decline',
                      textStyle:
                          Styles.font14w700.copyWith(color: Color(0xff4D4D4D)),
                      onTap: () {},
                      height: 30.h,
                    ),
                  ),
                  10.widthBox,
                  Expanded(
                    child: CustomAppButton(
                      label: 'Accept',
                      borderRadius: 15.r,
                      onTap: () {},
                      textStyle:
                          Styles.font14w700.copyWith(color: Colors.white),
                      height: 30.h,
                    ),
                  )
                ],
              ),
              10.heightBox,
            ],
          ),
        ),
      ],
    );
  }
}
