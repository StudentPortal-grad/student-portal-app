import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/widgets/custom_app_button.dart';
import 'package:student_portal/features/events/data/models/event_model.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_image_view.dart';

class GoingPeopleListView extends StatelessWidget {
  const GoingPeopleListView({
    super.key,
    this.stretch = false,
    this.text,
    this.rsvpUsers = const [],
  });

  final bool stretch;
  final String? text;
  final List<Rsvp> rsvpUsers;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Stacked Profile Pictures
        SizedBox(
          width: 120.w,
          height: 24.h,
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(
              rsvpUsers.length,
              (index) {
                if (index == 4) {
                  return Positioned(
                    left: index * 20.r,
                    child: Container(
                      height: 24.r,
                      width: 24.r,
                      decoration: BoxDecoration(
                        color: ColorsManager.lightBabyBlue,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '+${rsvpUsers.length - 4}',
                        style: Styles.font12w400.copyWith(
                            color: ColorsManager.mainColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }
                if (index < 4) {
                  return Positioned(
                    left: index * 20.r,
                    child: CustomImageView(
                      height: 24.r,
                      width: 24.r,
                      imagePath: rsvpUsers[index].rsvpUser?.profilePicture,
                      circle: true,
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ),
        stretch ? const Spacer() : const SizedBox(width: 8),
        text != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(text!, style: Styles.font13w400),
              )
            :
            // "Going" Button
            Padding(
                padding: const EdgeInsets.only(left: 4),
                child: CustomAppButton(
                  width: 60.w,
                  height: 24.h,
                  label: 'Going',
                  backgroundColor: Colors.white,
                  textStyle: Styles.font13w400.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.mainColor),
                  onTap: () {},
                ),
              ),
      ],
    );
  }
}
