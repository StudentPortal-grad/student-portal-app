import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../theming/colors.dart';
import '../theming/text_styles.dart';
import '../utils/assets_app.dart';
import 'custom_image_view.dart';

class UploadButton extends StatelessWidget {
  final VoidCallback onTap;

  const UploadButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 1.sw,
        // width: 300,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffE9EAEB)),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          children: [
            CustomImageView(imagePath: AssetsApp.cloudUpload),
            12.heightBox,
            RichText(
              text: TextSpan(
                text: "Click to upload ",
                style:
                Styles.font15w600.copyWith(color: ColorsManager.mainColor),
                children: [
                  TextSpan(
                    text: "or drag and drop",
                    style: Styles.font14w400,
                  ),
                ],
              ),
            ),
            5.heightBox,
            Text(
              "MP4, PDF or DOCX (max. 800 MB)",
              style: Styles.font12w400,
            ),
          ],
        ),
      ),
    );
  }
}