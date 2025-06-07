import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/extensions.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/widgets/custom_app_button.dart';

class WarningDialogBody extends StatelessWidget {
  const WarningDialogBody(
      {super.key,
      this.iconWidget,
      this.onTap,
      this.title,
      this.buttonTitle,
      this.subTitle,
      this.mainButton});

  final Widget? iconWidget;
  final Function()? onTap;
  final String? title, buttonTitle, subTitle;
  final Color? mainButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        iconWidget ?? errorIcon,
        16.heightBox,
        Text(
          title ?? "Delete Attachment",
          style: Styles.font18w600,
        ),
        8.heightBox,
        Text(
            subTitle ??
                "Are you sure you want to delete this attachment? This action cannot be undone.",
            textAlign: TextAlign.center,
            style: Styles.font14w400),
        24.heightBox,
        CustomAppButton(
          height: 44.h,
          backgroundColor: mainButton ?? Colors.red,
          label: buttonTitle ?? "Delete",
          textStyle: Styles.font16w700.copyWith(color: Colors.white),
          onTap: () => onTap?.call(),
        ),
        12.heightBox,
        CustomAppButton(
          height: 44.h,
          backgroundColor: Colors.transparent,
          textStyle: Styles.font16w700.copyWith(color: Colors.black),
          borderColor: ColorsManager.lightGrayColor,
          label: "Cancel",
          onTap: () => pop(),
        ),
      ]),
    );
  }

  static Widget get warmingIcon {
    return CircleAvatar(
      radius: 25.r,
      backgroundColor: Color(0xffFEF0C7).withValues(alpha: 0.4),
      child: CircleAvatar(
        backgroundColor: Color(0xffFEF0C7),
        radius: 17.r,
        child: Center(
          child: Icon(
            size: 25.r,
            Icons.warning_amber_rounded,
            color: Color(0xffDC6803),
          ),
        ),
      ),
    );
  }

  static Widget get errorIcon {
    return CircleAvatar(
      radius: 25.r,
      backgroundColor: Color(0xffFEE4E2).withValues(alpha: 0.4),
      child: CircleAvatar(
        backgroundColor: Color(0xffFEE4E2),
        radius: 17.r,
        child: Center(
          child: Icon(
            size: 25.r,
            Icons.error_outline_rounded,
            color: Color(0xffD92D20),
          ),
        ),
      ),
    );
  }
}
