import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/widgets/custom_app_button.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';

import '../../../../contestants.dart';
import '../../../../core/theming/colors.dart';
import '../widgets/event_info_card.dart';
import '../widgets/going_people_list_view.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          sliverAppBar(),
          SliverToBoxAdapter(
            child: Container(
              height: 1.sh,
              color: ColorsManager.backgroundColorLight2,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  Flexible(
                    child: Text(
                      'Tech Career Fair  2025',
                      style: Styles.font22w700.copyWith(
                        fontSize: 32.sp,
                        color: ColorsManager.textColor,
                      ),
                    ),
                  ),
                  20.heightBox,
                  EventInfoCard(),
                  20.heightBox,
                  _buildOrganizerCard(),
                  20.heightBox,
                  20.heightBox,
                  CustomAppButton(
                    label: 'Book a Seat',
                    height: 49.h,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar sliverAppBar() {
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
              imagePath: 'https://pbs.twimg.com/media/F-fJmSqXAAEMMHX.jpg',
              fit: BoxFit.cover,
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

  Widget _buildOrganizerCard() {
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
              Text('Organizer',
                  style: Styles.font12w400
                      .copyWith(color: ColorsManager.grayColor)),
            ],
          ),
          Spacer(),
          // if you not followed this user
          CustomAppButton(
            onTap: () {},
            label: 'Follow',
            textStyle: Styles.font12w400.copyWith(
                color: ColorsManager.mainColor, fontWeight: FontWeight.bold),
            height: 30.h,
            width: 70.w,
            borderRadius: 20.r,
            backgroundColor: ColorsManager.lightBlue,
          )
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildGoingPeople() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(15.sp),
      child: GoingPeopleListView(text: 'Going'),
    );
  }
}
