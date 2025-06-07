import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/contestants.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/resource/presentation/data/model/resource.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';

class UserPostView extends StatelessWidget {
  const UserPostView({super.key, this.uploader, this.createFromAgo});

  final Uploader? uploader;
  final String? createFromAgo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: uploader?.profilePicture ?? '',
          placeHolder: kUserPlaceHolder,
          circle: true,
          height: 38.r,
          width: 38.r,
        ),
        8.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(uploader?.name ?? '', style: Styles.font14w700),
            3.heightBox,
            Text(createFromAgo ?? '',
                style:
                    Styles.font12w400.copyWith(color: ColorsManager.grayColor)),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            // todo: open more options
          },
          icon: Icon(Icons.more_vert, color: ColorsManager.black41),
        )
      ],
    );
  }
}
