import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/loading_screen.dart';
import '../../data/models/event_model.dart';
import 'event_item_view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/events_bloc/events_bloc.dart';

class EventsBodyView extends StatefulWidget {
  const EventsBodyView({super.key, required this.events});

  final List<Event> events;

  @override
  State<EventsBodyView> createState() => _EventsBodyViewState();
}

class _EventsBodyViewState extends State<EventsBodyView> {
  late final ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final position = _scrollController.position;
    final isScrollable = position.maxScrollExtent > 0;

    if (isScrollable &&
        position.pixels >= position.maxScrollExtent - 300 &&
        !_isLoadingMore) {
      final bloc = context.read<EventsBloc>();
      final state = bloc.state;
      if (state is EventsLoaded && state.hasMore) {
        _isLoadingMore = true;
        bloc.add(EventsLoadMoreRequested());
      }
    }
  }

  @override
  void didUpdateWidget(covariant EventsBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLoadingMore = false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        final events = (state is EventsLoaded) ? state.events : widget.events;
        final hasMore = (state is EventsLoaded) ? state.hasMore : false;

        return SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Events Near You', style: Styles.font18w700),
              15.heightBox,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => AppRouter.router.push(
                      AppRouter.eventDetails,
                      extra: {'eventId': events[index].id},
                    ),
                    child: EventItemView(event: events[index]),
                  );
                },
                separatorBuilder: (context, index) => 10.heightBox,
                itemCount: events.length,
              ),
              if (hasMore)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: LoadingScreen(
                      highlightColor: ColorsManager.mainColor,
                      baseColor: ColorsManager.mainColorLight,
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

// ...[
//   Row(
//     children: [
//       Text(
//         'Upcoming Events',
//         style: Styles.font18w700,
//       ),
//       Spacer(),
//       // SeeAllButton(),
//     ],
//   ),
//   15.heightBox,
//   Container(
//     constraints: BoxConstraints(maxHeight: 360.h, minHeight: 300.h),
//     child: ListView.separated(
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) => InkWell(
//         onTap: () => AppRouter.router.push(AppRouter.eventDetails),
//         child: UpComingEventItemView(),
//       ),
//       separatorBuilder: (context, index) => 5.widthBox,
//       itemCount: 4,
//     ),
//   ),
//   30.heightBox,
// ],
