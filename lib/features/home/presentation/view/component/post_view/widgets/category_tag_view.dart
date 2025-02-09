import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/theming/text_styles.dart';

class CategoryTagView extends StatelessWidget {
  final String title;

  const CategoryTagView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Color(0xFFFFEAD5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Text(title, style: Styles.font12w400.copyWith(color: Colors.red)),
    );
  }
}
