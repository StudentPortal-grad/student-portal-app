import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/utils/app_router.dart';

import '../../../../core/theming/text_styles.dart';
import '../widgets/event_item_view.dart';
import '../widgets/upcoming_event_item_view.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Upcoming Events',
                style: Styles.font18w700,
              ),
              Spacer(),
              // SeeAllButton(),
            ],
          ),
          15.heightBox,
          Container(
            constraints: BoxConstraints(maxHeight: 360.h, minHeight: 300.h),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                onTap: () => AppRouter.router.push(AppRouter.eventDetails),
                child: UpComingEventItemView(),
              ),
              separatorBuilder: (context, index) => 5.widthBox,
              itemCount: 4,
            ),
          ),
          30.heightBox,
          Text(
            'Events Near You',
            style: Styles.font18w700,
          ),
          15.heightBox,
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => InkWell(
              onTap: () => AppRouter.router.push(AppRouter.eventDetails),
              child: EventItemView(),
            ),
            separatorBuilder: (context, index) => 10.heightBox,
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}
