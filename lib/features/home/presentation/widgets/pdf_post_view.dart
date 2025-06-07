import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/utils/url_launcher.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';

class PdfPostView extends StatelessWidget {
  const PdfPostView({super.key, this.title, this.url, this.size});

  final String? title;
  final int? size;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (url != null && url!.isNotEmpty) {
          UrlLauncher.website(url ?? '');
        }
      },
      child: Container(
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
                      title ?? 'File name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.font14w500,
                    ),
                    if (size != null)
                      Text(formatBytesToReadableUnit(size ?? 0), style: Styles.font14w400),
                  ],
                ),
              ),
              4.widthBox,
              Icon(Icons.download_rounded, color: ColorsManager.mainColor),
            ],
          )),
    );
  }

  String formatBytesToReadableUnit(int bytes) {
    const int kb = 1024;
    const int mb = 1024 * 1024;

    if (bytes >= mb) {
      double sizeInMb = bytes / mb;
      return '${sizeInMb.toStringAsFixed(2)} MB';
    } else {
      double sizeInKb = bytes / kb;
      return '${sizeInKb.toStringAsFixed(2)} KB';
    }
  }
}
