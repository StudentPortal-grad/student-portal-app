import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../contestants.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_image_view.dart';

class EventGoingPeopleCard extends StatelessWidget {
  const EventGoingPeopleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(15.sp),
      child: Row(
        children: [
          SizedBox(
            width: 110.w,
            height: 28.h,
            child: Stack(
              alignment: Alignment.center,
              children: List.generate(
                5,
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
                          '+5',
                          style: Styles.font12w400.copyWith(
                              color: ColorsManager.mainColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  }
                  return Positioned(
                    left: index * 20.r,
                    child: CustomImageView(
                      height: 30.r,
                      width: 30.r,
                      imagePath: kUserImage,
                      circle: true,
                    ),
                  );
                },
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: CustomAppButton(
              width: 80.w,
              height: 24.h,
              label: 'Interested',
              backgroundColor: Colors.white,
              textStyle: Styles.font13w400.copyWith(
                  fontWeight: FontWeight.w600, color: ColorsManager.mainColor),
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: CustomAppButton(
              width: 60.w,
              height: 24.h,
              label: 'Going',
              backgroundColor: Colors.white,
              textStyle: Styles.font13w400.copyWith(fontWeight: FontWeight.w600, color: ColorsManager.mainColor),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
