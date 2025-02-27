import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/text_styles.dart';
import '../widgets/event_item_view.dart';
import '../widgets/up_coming_eventI_itm_view.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 28.w),
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
              itemBuilder: (context, index) => UpComingEventItemView(),
              separatorBuilder: (context, index) => 15.widthBox,
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
            itemBuilder: (context, index) => EventItemView(),
            separatorBuilder: (context, index) => 15.heightBox,
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}
