import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/events/data/models/event_model.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';
import 'going_people_list_view.dart';

class EventItemView extends StatelessWidget {
  const EventItemView({super.key, this.event});

  final Event? event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 2,
              blurStyle: BlurStyle.outer,
            ),
          ]),
      margin: EdgeInsets.all(8.r),
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
                // imagePath: AssetsApp.testVideoImage,
                imagePath: event?.eventImage,
              ),
              10.widthBox,
              Expanded(
                child: Text(
                  event?.title ?? 'NULL',
                  style:
                      Styles.font18w600.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              10.widthBox,
              CircleAvatar(
                backgroundColor: ColorsManager.lightBabyBlue,
                child: Icon(
                  Icons.bookmark,
                  color:
                      ColorsManager.lightGrayColor, // ColorsManager.mainColor
                ),
              )
            ],
          ),
          10.heightBox,
          Text(
            event?.description ??
                'Join us for the Tech Career Fair on March 15, 2024, at the Downtown Convention Center!',
            style: Styles.font14w400,
          ),
          10.heightBox,
          GoingPeopleListView(
            rsvpUsers: event?.rsvps ?? [],
          ),
          10.heightBox,
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 15.r,
                color: ColorsManager.lightGrayColor,
              ),
              1.5.widthBox,
              Text(formatDateTimeRange(event?.startDate, event?.endDate),
                  style: Styles.font13w400)
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
              Text(event?.location ?? "The Location not defined yet", style: Styles.font13w400)
            ],
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) return 'Date not defined yet';
    final DateFormat formatter = DateFormat('d MMMM, y');
    return formatter.format(dateTime);
  }

  String formatDateTimeRange(DateTime? start, DateTime? end) {
    if (start == null || end == null) {
      return 'Time not defined yet';
    }

    final dayFormat = DateFormat('EEEE'); // e.g., Tuesday
    final timeFormat = DateFormat('h:mma'); // e.g., 4:00PM

    String day = dayFormat.format(start);
    String startTime = timeFormat.format(start);
    String endTime = timeFormat.format(end);

    return '$day, $startTime - $endTime';
  }
}
