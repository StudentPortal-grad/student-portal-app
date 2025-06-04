import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';
import 'package:student_portal/features/events/presentation/manager/events_bloc/events_bloc.dart';

import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../widgets/events_body_view.dart';

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
          return CustomRefreshIndicator(
            onRefresh: () async => context.read<EventsBloc>().add(EventsRequested()),
            child: Center(
              child: Text(state.error),
            ),
          );
        }
        if (state is EventsLoaded) {
          return CustomRefreshIndicator(
            onRefresh: () async =>
                context.read<EventsBloc>().add(EventsRequested()),
            child: EventsBodyView(events: state.events),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
