import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_app_button.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import 'package:student_portal/core/widgets/custom_refresh_indicator.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';
import 'package:student_portal/features/events/data/enum/event.dart';
import 'package:student_portal/features/events/presentation/manager/event_details_bloc/event_details_bloc.dart';

import '../../../../contestants.dart';
import '../../../../core/theming/colors.dart';
import '../../../auth/data/model/user_model/user.dart';
import '../../data/dto/event_rsvp.dart';
import '../../data/models/event_model.dart';
import '../manager/book_seat_bloc/book_seat_bloc.dart';
import '../widgets/event_going_people_card.dart';
import '../widgets/event_info_card.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BookSeatBloc(), // to book seat to event or cancel
        child: BlocProvider(
          create: (context) =>
              EventDetailsBloc()..add(EventsRequested(eventId: eventId)),
          child: BlocBuilder<EventDetailsBloc, EventDetailsState>(
              builder: (context, state) {
            if (state is EventDetailsFailure) {
              return Center(child: Text(state.failureMessage));
            }
            if (state is EventDetailsLoading) {
              return LoadingScreen(showAppBar: true);
            } else if (state is EventDetailsLoaded) {
              return CustomRefreshIndicator(
                onRefresh: () async => BlocProvider.of<EventDetailsBloc>(context).add(EventsRequested(eventId: eventId,noLoading: true)),
                child: CustomScrollView(
                  slivers: [
                    sliverAppBar(state.event.eventImage ?? ''),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 1.sh,
                        color: ColorsManager.backgroundColorLight2,
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                        child: Column(
                          children: [
                            Flexible(
                              child: Text(
                                state.event.title ?? '',
                                style: Styles.font22w700.copyWith(
                                  fontSize: 32.sp,
                                  color: ColorsManager.textColor,
                                ),
                              ),
                            ),
                            20.heightBox,
                            EventInfoCard(event: state.event),
                            20.heightBox,
                            _buildOrganizerCard(),
                            20.heightBox,
                            EventGoingPeopleCard(
                              rsvpUser: state.event.rsvps ?? [],
                            ),
                            20.heightBox,
                            BlocConsumer<BookSeatBloc, BookSeatState>(
                              listener: (context, state) {
                                print('ssss STATE $state');
                                if(state is BookSeatLoaded){
                                  BlocProvider.of<EventDetailsBloc>(context).add(EventsRequested(eventId: eventId,noLoading: true));
                                }
                              },
                              builder: (bookContext, bookState) {
                                final userId = UserRepository.user?.id;
                                final alreadyBooked = state.event.rsvps?.any((Rsvp rsvp) {
                                  if (rsvp.rsvpUser?.id == userId) {
                                    return rsvp.status == EventState.attending.value;
                                  }
                                  return false;
                                }) ?? false;
                                return CustomAppButton(
                                  loading: bookState is BookSeatLoading,
                                  label: alreadyBooked ? "Leave the Seat" : "Book a Seat",
                                  height: 49.h,
                                  onTap: () {
                                    final newStatus = alreadyBooked
                                        ? EventState.notAttending.value
                                        : EventState.attending.value;

                                    final eventId = state.event.id ?? '';

                                    bookContext.read<BookSeatBloc>().add(
                                      BookSeatRequested(EventRsvpDTO(
                                        status: newStatus,
                                        eventId: eventId,
                                      )),
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          }),
        ),
      ),
    );
  }

  SliverAppBar sliverAppBar(String eventImage) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 195.h,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        centerTitle: true,
        expandedTitleScale: 1.2,
        title: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          fit: StackFit.expand,
          children: [
            CustomImageView(
              imagePath: eventImage,
              fit: BoxFit.cover,
              placeHolder: AssetsApp.backgroundProfile,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.2),
                    Colors.white.withValues(alpha: 0.3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: BackButton(color: Colors.white),
      centerTitle: true,
      scrolledUnderElevation: 0,
      title: "Event Details".make(style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildOrganizerCard({User? user}) {
    if (user == null) return SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(15.sp),
      child: Row(
        children: [
          CustomImageView(
            radius: BorderRadius.all(Radius.circular(15.r)),
            width: 44.r,
            height: 44.r,
            imagePath: kUserImage,
          ),
          10.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mina Zarif', style: Styles.font15w600),
              3.heightBox,
              Text(
                'Organizer',
                style:
                    Styles.font12w400.copyWith(color: ColorsManager.grayColor),
              ),
            ],
          ),
          // Spacer(),
          // if you not followed this user
          // CustomAppButton(
          //   onTap: () {},
          //   label: 'Follow',
          //   textStyle: Styles.font12w400.copyWith(
          //       color: ColorsManager.mainColor, fontWeight: FontWeight.bold),
          //   height: 30.h,
          //   width: 70.w,
          //   borderRadius: 20.r,
          //   backgroundColor: ColorsManager.lightBlue,
          // )
        ],
      ),
    );
  }
}
