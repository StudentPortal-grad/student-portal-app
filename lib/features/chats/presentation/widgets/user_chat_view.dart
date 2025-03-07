import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/contestants.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../auth/data/model/user_model/user.dart';
import '../../data/model/message.dart';

class UserChatView extends StatelessWidget {
  const UserChatView(
      {super.key, this.pinned = false, this.lastMessage, this.user});

  final bool pinned;
  final Message? lastMessage;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.router.push(AppRouter.dmScreen);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            height: 56.r,
            width: 56.r,
            imagePath: kUserImage,
            circle: true,
            fit: BoxFit.contain,
          ),
          10.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    user?.name ?? '',
                    style:
                        Styles.font18w600.copyWith(fontWeight: FontWeight.w500),
                  ),
                  8.widthBox,
                  if (pinned)
                    Icon(
                      Icons.push_pin,
                      color: ColorsManager.mainColor,
                      size: 20.sp,
                    )
                ],
              ),
              Row(
                children: [
                  Text(
                    lastMessage?.content ?? '',
                    style: Styles.font12w400.copyWith(
                        fontSize: 14.sp, color: ColorsManager.lightGrayColor),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Text(
            lastMessage?.formattedTime() ?? '',
            style: Styles.font12w400.copyWith(
              fontSize: 10.sp,
              color: ColorsManager.lightGrayColor,
            ),
          ),
        ],
      ),
    );
  }
}
