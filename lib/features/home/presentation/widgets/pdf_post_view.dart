import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';

class PdfPostView extends StatelessWidget {
  const PdfPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ColorsManager.lightBabyBlue,
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
        ),
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15.r,
              backgroundColor: ColorsManager.babyBlue,
              child: CustomImageView(
                imagePath: AssetsApp.fileIcon,
                height: 16.r,
                width: 16.r,
              ),
            ),
            14.widthBox,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Research Methods.pdf',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.font14w500,
                  ),
                  Text('200 KB', style: Styles.font14w400),
                ],
              ),
            ),
            4.widthBox,
            Icon(Icons.download_rounded, color: ColorsManager.mainColor),
          ],
        ));
  }
}
