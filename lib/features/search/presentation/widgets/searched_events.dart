import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../events/presentation/widgets/event_item_view.dart';

class SearchedEvents extends StatelessWidget {
  const SearchedEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
      itemBuilder: (context, index) => EventItemView(),
      separatorBuilder: (context, index) => 15.heightBox,
      itemCount: 3,
    );
  }
}
