import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';

import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/model/message.dart' as model;

class MessageItemView extends StatelessWidget {
  const MessageItemView({super.key, required this.message});

  final model.Message message;

  @override
  Widget build(BuildContext context) {
    final self = message.from == '0'; //UserRepository.user?.id
    return Column(
      crossAxisAlignment: self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: self
              ? BoxDecoration(
                  color: ColorsManager.lightGreyColor.withOpacity(0.4),
                  borderRadius: BorderRadius.all(
                    Radius.circular(13.r),
                  ),
                )
              : BoxDecoration(
                  color: ColorsManager.mainColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(13.r),
                  ),
                ),
          child: Column(
            children: [
              if (message.files?.isNotEmpty ?? false) ...[
                CustomImageView(imagePath: message.files?[0].url),
                if (message.message?.isNotEmpty ?? false) ...[
                  10.heightBox,
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: AppText(
                      text: message.message ?? '',
                      // style: AppTextStyles.blackMedium.copyWith(height: 1.50),
                      // size: 16.sp,
                    ),
                  ),
                ]
              ] else
                AppText(
                  text: message.message ?? '',
                  // style: AppTextStyles.blackMedium.copyWith(height: 1.50),
                  // size: 16.sp,
                ),
            ],
          ),
        ),
        5.heightBox,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: message.updatedAt ?? '',
              // style: ,
            ),
            // if(self) ...[
            //   5.widthBox,
            //   Icon(message.id == '0' ? FontAwesomeIcons.circle : FontAwesomeIcons.circleCheck, color: AppColors.primary, size: 12.sp),
            // ]
          ],
        )
      ],
    );
  }
}
