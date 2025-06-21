import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';
import 'package:student_portal/features/events/presentation/manager/events_bloc/events_bloc.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/errors/view/error_screen.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../widgets/events_body_view.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is EventsLoading) {
          return Center(
            child: LoadingScreen(useMainColors: true),
          );
        }
        if (state is EventsError) {
          return ErrorScreen(
            failure: Failure(message: state.message),
            onRetry: () async =>
                context.read<EventsBloc>().add(EventsRequested()),
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
