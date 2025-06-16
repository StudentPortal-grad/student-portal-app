import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/events/data/models/event_model.dart';

import '../../../events/presentation/widgets/event_item_view.dart';
import '../screens/not_found_search_view.dart';

class SearchedEvents extends StatelessWidget {
  const SearchedEvents({super.key, this.events = const []});

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) return const NotFoundView();

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
      itemBuilder: (context, index) => EventItemView(event: events[index]),
      separatorBuilder: (context, index) => 15.heightBox,
      itemCount: events.length,
    );
  }
}
