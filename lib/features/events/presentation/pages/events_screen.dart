import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';
import 'package:student_portal/features/events/presentation/manager/events_bloc/events_bloc.dart';

import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../widgets/event_item_view.dart';
import '../widgets/upcoming_event_item_view.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading) {
          return Center(
            child: LoadingScreen(
              highlightColor: ColorsManager.mainColor,
              baseColor: ColorsManager.mainColorLight,
            ),
          );
        }
        if (state is EventsError) {
          return Center(
            child: Text(state.error),
          );
        }
        return CustomRefreshIndicator(
          onRefresh: () async => context.read<EventsBloc>().add(EventsRequested()),
          child: SingleChildScrollView(
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
                  constraints:
                      BoxConstraints(maxHeight: 360.h, minHeight: 300.h),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () =>
                          AppRouter.router.push(AppRouter.eventDetails),
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
                    onTap: () =>
                        AppRouter.router.push(AppRouter.eventDetails),
                    child: EventItemView(),
                  ),
                  separatorBuilder: (context, index) => 10.heightBox,
                  itemCount: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
