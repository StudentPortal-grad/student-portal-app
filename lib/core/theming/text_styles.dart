import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

abstract class Styles {
  static TextStyle font22w700 = TextStyle(
    fontWeight: FontWeight.w700,
    color: ColorsManager.mainColor,
    fontSize: 22.sp,
  );
  static TextStyle font12w400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: Color(0xff7D8A95),
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

  static TextStyle font14w400 = TextStyle(
    color: Color(0xFF535862),
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
}
