import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theming/colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 10.w),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SpinKitThreeInOut(
          color: ColorsManager.mainColor,
          size: size ?? 30.sp,
        ),
      ),
    );
  }
}