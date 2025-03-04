import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/events/presentation/widgets/going_people_list_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';

class UpComingEventItemView extends StatelessWidget {
  const UpComingEventItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 0.8.sw,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                height: 140.h,
                width: 0.8.sw,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(8.r),
                imagePath: AssetsApp.testVideoImage,
              ),
              25.heightBox,
              Text('Tech Career Fair 2025', style: Styles.font18w600),
              3.heightBox,
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 15.r,
                    color: ColorsManager.lightGrayColor,
                  ),
                  1.5.widthBox,
                  Text('Sat, 1 May 2025 • 11:00 AM', style: Styles.font13w400)
                ],
              ),
              10.heightBox,
              Text(
                'Join us for the Tech Career Fair on March 15, 2024, at the Downtown Convention Center!',
                style: Styles.font14w400,
              ),
              10.heightBox,
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 16.r,
                    color: ColorsManager.lightGrayColor,
                  ),
                  1.5.widthBox,
                  Text('36 Guild Street London, UK', style: Styles.font13w400)
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 24.w,
          top: 130.h,
          child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 5),
                    blurRadius: 15,
                  ),
                ],
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
              ),
              child: GoingPeopleListView()),
        ),
      ],
    );
  }
}
