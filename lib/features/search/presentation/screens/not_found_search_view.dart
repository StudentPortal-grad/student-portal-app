import 'package:flutter/material.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: AssetsApp.search3Icon,
        ),
        20.heightBox,
        Text('No Results Found!', style: Styles.font20w600),
        12.heightBox,
        Text(
          'Try a similar word or something more general.',
          style: Styles.font14w400,
        ),
      ],
    );
  }
}
