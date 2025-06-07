
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/utils/assets_app.dart';
import '../../../../../core/widgets/custom_image_view.dart';
import '../../data/model/resource.dart';

class ResourceReactBar extends StatefulWidget {
  const ResourceReactBar({super.key, this.resource});

  final Resource? resource;

  @override
  State<ResourceReactBar> createState() => _ResourceReactBarState();
}

class _ResourceReactBarState extends State<ResourceReactBar> {
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
            onTap: () => _onItemTapped((react == 1) ? 0 : 1),
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
          Text((widget.resource?.comments?.length ?? 0).toString(), style: Styles.font14w500),
          Spacer(),
          GestureDetector(
            onTap: () {
              final resource = widget.resource;
              SharePlus.instance.share(
                ShareParams(
                  text: ("Student Portal - Check out this ${resource?.originalFileName} article:\n ${resource?.fileUrl}"),
                ),
              );
            },
            child: Row(
              children: [
                CustomImageView(
                  imagePath: AssetsApp.shareIcon,
                  width: 16.w,
                  height: 16.h,
                ),
                4.widthBox,
                Text('Share', style: Styles.font14w500),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
