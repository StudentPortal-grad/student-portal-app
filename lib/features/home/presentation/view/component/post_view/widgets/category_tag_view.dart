import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import '../../../../../../../core/theming/text_styles.dart';

class CategoryTagView extends StatelessWidget {
  final String title;
  final Color? backGround;
  final Color? textColor;
  final Color? borderColor;
  final Function(String)? removeTap;

  const CategoryTagView({
    super.key,
    required this.title,
    this.backGround,
    this.textColor,
    this.borderColor,
    this.removeTap, // make it == null to disappear remove icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: backGround ?? Color(0xFFFFEAD5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: 2)
              : BorderSide.none,
        ),
      ),
      padding: EdgeInsetsDirectional.only(start: 12.w, top: 4.h, bottom: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Styles.font12w400.copyWith(color: textColor ?? Colors.red),
          ),
          8.widthBox,
          if (removeTap != null)
            InkWell(
              onTap: () => removeTap!(title),
              child: CircleAvatar(
                radius: 10.r,
                backgroundColor: ColorsManager.babyBlue,
                child: Icon(Icons.close, size: 12.8.r, color: borderColor),
              ),
            ),
          4.widthBox,
        ],
      ),
    );
  }
}
