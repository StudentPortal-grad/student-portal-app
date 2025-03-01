import 'package:flutter/material.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';

class NoNotificationsView extends StatelessWidget {
  const NoNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(imagePath: AssetsApp.notification2Icon),
          24.heightBox,
          "You haven’t gotten any notifications yet!"
              .make(style: Styles.font20w600),
          12.heightBox,
          "We’ll alert you when something cool happens."
              .make(style: Styles.font14w400)
        ],
      ),
    );
  }
}
