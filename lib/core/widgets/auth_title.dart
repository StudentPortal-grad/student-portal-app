import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/assets_app.dart';
import '../theming/text_styles.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AssetsApp.logo,
          alignment: Alignment.center,
          width: 33.w,
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: Styles.font22w700,
        ),
      ],
    );
  }
}
