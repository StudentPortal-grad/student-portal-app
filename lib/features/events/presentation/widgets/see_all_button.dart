import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/text_styles.dart';

class SeeAllButton extends StatelessWidget {
  const SeeAllButton({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text('See All', style: Styles.font12w400),
          Icon(Icons.arrow_right_rounded, color: Color(0xff7D8A95),size: 18.r,),
        ],
      ),
    );
  }
}
