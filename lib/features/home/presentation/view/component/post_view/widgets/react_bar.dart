import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/utils/assets_app.dart';
import '../../../../../../../core/widgets/custom_image_view.dart';

class ReactBar extends StatelessWidget {
  const ReactBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          CustomImageView(
            imagePath: AssetsApp.arrowUpIcon,
            color: ColorsManager.mainColorDark,
            width: 16.w,
            height: 16.h,
          ),
          4.widthBox,
          Text('215', style: Styles.font14w500),
          4.widthBox,
          CustomImageView(
            imagePath: AssetsApp.arrowDownIcon,
            // color: ColorsManager.orangeColor,
            width: 16.w,
            height: 16.h,
          ),
          Spacer(),
          CustomImageView(
            imagePath: AssetsApp.chatIcon,
            color: Colors.grey[300],
            width: 16.w,
            height: 16.h,
          ),
          4.widthBox,
          Text('15', style: Styles.font14w500),
          Spacer(),
          CustomImageView(
            imagePath: AssetsApp.shareIcon,
            width: 16.w,
            height: 16.h,
          ),
          4.widthBox,
          Text('Share', style: Styles.font14w500),
        ],
      ),
    );
  }
}
