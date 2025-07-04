import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/features/groups/data/models/user_sibling.dart';

import '../../../../contestants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_image_view.dart';

class UserSearchedView extends StatelessWidget {
  const UserSearchedView({super.key, this.user,  this.showDmButton = false});

  final UserSibling? user;
  final bool showDmButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.router.push(
          AppRouter.profile,
          extra: {'userId': user?.id},
        );
      },
      child: Row(
        children: [
          CustomImageView(
            imagePath: user?.profilePicture,
            placeHolder: kUserPlaceHolder,
            width: 48.r,
            height: 48.r,
            circle: true,
          ),
          12.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (user?.name ?? '').make(style: Styles.font18w600),
              (user?.userName ?? '').make(
                  style: Styles.font16w500.copyWith(
                      fontWeight: FontWeight.w400, color: ColorsManager.black53)),
            ],
          ),
          if (showDmButton) ...[
            Spacer(),
            CustomImageView(
              onTap: () => AppRouter.router.push(AppRouter.dmScreen, extra: {'userId': user?.id}),
              imagePath: AssetsApp.chatIcon,
              color: ColorsManager.mainColorLight,
            ),
          ]
        ],
      ),
    );
  }
}
