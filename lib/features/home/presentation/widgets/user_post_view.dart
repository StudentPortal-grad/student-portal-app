import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';

class UserPostView extends StatelessWidget {
  const UserPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: 'https://avatars.githubusercontent.com/u/92533130',
          circle: true,
          height: 38.r,
          width: 38.r,
        ),
        8.widthBox,
        Column(
          children: [
            Text("Mina Zarif", style: Styles.font14w700),
            3.heightBox,
            Text("10 min ago",
                style:
                    Styles.font12w400.copyWith(color: ColorsManager.grayColor)),
          ],
        ),
        Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: ColorsManager.black41))
      ],
    );
  }
}
