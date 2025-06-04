import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/events/data/models/event_model.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_image_view.dart';

class EventGoingPeopleCard extends StatelessWidget {
    const EventGoingPeopleCard({super.key, this.rsvpUser = const []});

  final List<Rsvp> rsvpUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(15.sp),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          50.widthBox,
          SizedBox(
            width: 110.w,
            height: 28.h,
            child: Stack(
              alignment: Alignment.center,
              children: List.generate(
                rsvpUser.length,
                (index) {
                  if (index == 4) {
                    return Positioned(
                      left: index * 20.r,
                      child: Container(
                        height: 30.r,
                        width: 30.r,
                        decoration: BoxDecoration(
                          color: ColorsManager.lightBabyBlue,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '+${rsvpUser.length - 4}',
                          style: Styles.font12w400.copyWith(
                              color: ColorsManager.mainColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  }
                  if(index < 4) {
                    return Positioned(
                    left: index * 20.r,
                    child: CustomImageView(
                      height: 30.r,
                      width: 30.r,
                      imagePath: rsvpUser[index].rsvpUser?.profilePicture,
                      circle: true,
                    ),
                  );
                  }
                  return SizedBox();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: CustomAppButton(
              width: 60.w,
              height: 24.h,
              label: 'Going',
              backgroundColor: Colors.white,
              textStyle: Styles.font13w400.copyWith(
                  fontWeight: FontWeight.w600, color: ColorsManager.mainColor),
              onTap: () {},
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 8),
          //   child: CustomAppButton(
          //     width: 80.w,
          //     height: 30.h,
          //     borderRadius: 8.r,
          //     label: 'Interested',
          //     backgroundColor: ColorsManager.mainColor,
          //     textStyle: Styles.font13w400.copyWith(
          //         fontWeight: FontWeight.w600, color: ColorsManager.whiteColor),
          //     onTap: () {},
          //   ),
          // ),
        ],
      ),
    );
  }
}
