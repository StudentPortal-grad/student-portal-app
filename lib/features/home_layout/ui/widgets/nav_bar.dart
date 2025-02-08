import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_portal/core/theming/colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.barMargin = EdgeInsets.zero,
    this.itemPadding = const EdgeInsets.symmetric(vertical: 20),
    this.floatingOnTap,
  });

  final List<NavBarButtonItem> items;
  final int currentIndex;
  final Function(int value)? onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final EdgeInsets barMargin;
  final EdgeInsets itemPadding;
  final Function()? floatingOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          if (backgroundColor != null)
            BoxShadow(
              color: backgroundColor!.withValues(alpha: 0.3),
              offset: const Offset(0, 5),
              blurRadius: 10,
            ),
        ],
      ),
      margin: barMargin,
      padding: itemPadding,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            items.length,
            (index) {
              if (index == (items.length ~/ 2)) {
                return Container(
                  margin: EdgeInsets.only(left: 7.w, bottom: 6.h),
                  width: 35.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.mainColorDark,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: floatingOnTap,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  ),
                );
              }
              return GestureDetector(
                onTap: () => onTap?.call(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      items[index].iconPath,
                      width: 20.w,
                      height: 20.h,
                      colorFilter: ColorFilter.mode(
                          currentIndex == index
                              ? ColorsManager.mainColorLight
                              : ColorsManager.mainColorDark,
                          BlendMode.srcIn),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index].title,
                      style: TextStyle(
                        color: currentIndex == index
                            ? ColorsManager.mainColorLight
                            : ColorsManager.mainColorDark,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A tab item for the CustomNavBar
class NavBarButtonItem {
  final String iconPath;
  final String title;
  final Color? selectedColor;
  final Color? unselectedColor;

  NavBarButtonItem({
    required this.iconPath,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
  });
}
