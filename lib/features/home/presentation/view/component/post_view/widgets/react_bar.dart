import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/utils/assets_app.dart';
import '../../../../../../../core/widgets/custom_image_view.dart';

class ReactBar extends StatefulWidget {
  const ReactBar({super.key});

  @override
  State<ReactBar> createState() => _ReactBarState();
}

class _ReactBarState extends State<ReactBar> {
  int react = 0;

  void _onItemTapped(int index) {
    setState(() {
      react = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          CustomImageView(
            onTap: () => _onItemTapped((react == 1) ? 0 : 1 ),
            imagePath: AssetsApp.arrowUpIcon,
            color: react == 1 ? ColorsManager.mainColorDark : null,
            width: 16.w,
            height: 16.h,
          ),
          4.widthBox,
          Text(react.toString(), style: Styles.font14w500),
          4.widthBox,
          CustomImageView(
            onTap: () => _onItemTapped((react == -1) ? 0 : -1),
            imagePath: AssetsApp.arrowDownIcon,
            color: react == -1 ? ColorsManager.orangeColor : null,
            width: 16.w,
            height: 16.h,
          ),
          Spacer(),
          CustomImageView(
            imagePath: AssetsApp.commentIcon,
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
