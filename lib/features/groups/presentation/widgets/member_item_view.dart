import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../contestants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../auth/data/model/user_model/user.dart';

class MemberItemView extends StatelessWidget {
  const MemberItemView({
    super.key,
    required this.user,
    this.onRemoveTap,
    this.showRemoveIcon = true,
    this.suffix,
    this.showIsMemberSelected = false,
  });

  final User user;
  final Function(String id)? onRemoveTap;
  final bool showRemoveIcon;
  final bool showIsMemberSelected;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
            height: 56.r,
            width: 56.r,
            imagePath: kUserImage,
            circle: true,
            fit: BoxFit.contain,
          ),
          10.widthBox,
          Expanded(
            child: Text(
              user.name ?? '',
              style: Styles.font18w600.copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Visibility(
            visible: showRemoveIcon,
            child: IconButton(
              onPressed: () => onRemoveTap?.call(user.id ?? ''),
              icon: const Icon(Icons.remove, color: Colors.red),
            ),
          ),
          Visibility(
            visible: showIsMemberSelected,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: ColorsManager.mainColor,
              ),
              padding: EdgeInsets.all(3.5.r),
              child: Icon(Icons.check_rounded, size: 18.r, color: Colors.white),
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
