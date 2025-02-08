import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

abstract class Styles {
  static  TextStyle title = TextStyle(
    fontWeight: FontWeight.w700,
    color: ColorsManager.mainColor,
    fontSize: 22.sp,
  );
  static TextStyle subTitle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: Color(0xff7D8A95),
  );
}
