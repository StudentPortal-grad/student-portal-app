import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/groups/data/models/user_sibling.dart';

import '../../../../contestants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';

class MemberItemView extends StatelessWidget {
  const MemberItemView({
    super.key,
    required this.userSibling,
    this.onRemoveTap,
    this.showRemoveIcon = true,
    this.suffix,
    this.showIsMemberSelected = false,
    this.onTap
  });

  final UserSibling userSibling;
  final Function(String id)? onRemoveTap;
  final Function()? onTap;
  final bool showRemoveIcon;
  final bool showIsMemberSelected;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
            height: 56.r,
            width: 56.r,
            imagePath: userSibling.profilePicture,
            placeHolder: kUserPlaceHolder,
            circle: true,
            fit: BoxFit.cover,
          ),
          10.widthBox,
          Expanded(
            child: Text(
              userSibling.name ?? '',
              style: Styles.font18w600.copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Visibility(
            visible: showRemoveIcon,
            child: IconButton(
              onPressed: () => onRemoveTap?.call(userSibling.id ?? ''),
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
