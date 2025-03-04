import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';
import 'going_people_list_view.dart';

class EventItemView extends StatelessWidget {
  const EventItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
      padding: EdgeInsets.all(15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImageView(
                width: 45.w,
                height: 45.h,
                fit: BoxFit.fill,
                radius: BorderRadius.circular(10.r),
                imagePath: AssetsApp.testVideoImage,
              ),
              10.widthBox,
              Flexible(
                  child: Text('Tech Career Fair 2025',
                      style: Styles.font18w600
                          .copyWith(fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis)),
              CircleAvatar(
                backgroundColor: ColorsManager.lightBabyBlue,
                child: Icon(
                  Icons.bookmark,
                  color: ColorsManager
                      .mainColor, // if(not_selected)  ColorsManager.lightGreyColor
                ),
              )
            ],
          ),
          10.heightBox,
          Text(
            'Join us for the Tech Career Fair on March 15, 2024, at the Downtown Convention Center!',
            style: Styles.font14w400,
          ),
          10.heightBox,
          GoingPeopleListView(),
          10.heightBox,
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
    );
  }
}
