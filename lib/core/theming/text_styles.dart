import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

abstract class Styles {
  static TextStyle font22w700 = TextStyle(
    fontWeight: FontWeight.w700,
    color: ColorsManager.mainColor,
    fontSize: 22.sp,
  );
  static TextStyle font16w700 = TextStyle(
    fontWeight: FontWeight.w700,
    color: ColorsManager.mainColor,
    fontSize: 16.sp,
  );
  static TextStyle font18w700 = TextStyle(
    fontWeight: FontWeight.w700,
    color: ColorsManager.blackColor,
    fontSize: 18.sp,
  );

  static TextStyle font10w600 = TextStyle(
    fontWeight: FontWeight.w600,
    color: ColorsManager.mainColor,
    fontSize: 10.sp,
  );
  static TextStyle font15w600 = TextStyle(
    fontWeight: FontWeight.w600,
    color: ColorsManager.blackColor,
    fontSize: 15.sp,
  );

  static TextStyle font15w500 = TextStyle(
    fontWeight: FontWeight.w500,
    color: ColorsManager.mainColor,
    fontSize: 15.sp,
  );
  static TextStyle font12w400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: Color(0xff7D8A95),
  );

  static TextStyle font20w600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    color: Color(0xff120D26),
  );

  static TextStyle font18w600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
    color: ColorsManager.textColor,
  );
  static TextStyle font14w700 = TextStyle(
    color: Color(0xFF0C1326),
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );

  static TextStyle font14w500 = TextStyle(
    color: Color(0xFF1E1F20),
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font16w500 = TextStyle(
    color: Color(0xff181D27),
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle font14w400 = TextStyle(
    color: Color(0xFF535862),
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font13w400 = TextStyle(
    color: ColorsManager.lightGrayColor,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
  );
}
