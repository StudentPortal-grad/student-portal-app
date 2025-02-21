import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';

import '../utils/app_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.action,
    this.leadingOnTap,
    this.titleOnTap,
    this.actionOnTap,
    this.backgroundColor,
    this.elevation = 0,
    this.centerTitle = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final Widget? leading, title, action;
  final Function()? leadingOnTap, titleOnTap, actionOnTap;
  final Color? backgroundColor;
  final double elevation;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Colors.white,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      elevation: elevation,
      leading: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: leadingOnTap ?? () => AppRouter.router.pop(),
        child: Center(
          child: leading ??
              CustomImageView(
                imagePath: AssetsApp.arrowBackIcon,
                width: 21.w,
                height: 15.h,
                fit: BoxFit.none,
              ),
        ),
      ),
      title: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: titleOnTap,
        child: title ?? const SizedBox(),
      ),
      actions: [
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: actionOnTap ?? () {},
          child: action ?? const SizedBox(),
        ),
        const SizedBox(width: 15)
      ],
    );
  }
}

class CustomLeadingButton extends StatelessWidget {
  const CustomLeadingButton({
    super.key,
    this.iconData = Icons.keyboard_arrow_left,
    this.radius = 16,
    this.backgroundColor = Colors.transparent,
  });

  final IconData iconData;
  final double radius;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xff2d2d2e)),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Icon(
        iconData,
        size: radius + 5,
        color: Colors.white,
      ),
    );
  }
}
