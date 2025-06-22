import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../contestants.dart';
import '../../../../core/helpers/time_formatting_helper.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../data/model/notification.dart';

class NotificationItemView extends StatelessWidget {
  const NotificationItemView({super.key, this.notification});

  final NotificationModel? notification;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          onTap: () {
            // AppRouter.router.push(AppRouter.profile, extra: {'userId': user?.id});
          },
          circle: true,
          width: 48.r,
          height: 48.r,
          imagePath: kUserImage,
          placeHolder: kUserPlaceHolder,
        ),
        12.widthBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: notification?.content ??'',
                style: Styles.font14w500.copyWith(height: 1.5),
              ),
              5.heightBox,
              TimeHelper.instance
                  .timeAgo(notification?.createdAt ?? DateTime.now())
                  .make(
                    style: Styles.font14w500.copyWith(
                      color: ColorsManager.gray3,
                      fontSize: 13.sp,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
