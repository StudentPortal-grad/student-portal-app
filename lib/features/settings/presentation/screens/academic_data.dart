import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/choose_position_button.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text_field.dart';

class AcademicDataScreen extends StatelessWidget {
  const AcademicDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColorLight,
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.backgroundColorLight,
        title: "Academic Data".make(style: Styles.font20w600),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          spacing: 20.h,
          children: [
            CustomTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your University';
                }
              },
              textInputType: TextInputType.name,
              hintText: "University",
              labelText: 'University',
              labelStyle: Styles.font14w500,
              controller: TextEditingController(),
            ),
            CustomTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Department';
                }
              },
              textInputType: TextInputType.name,
              hintText: "Collage",
              labelText: 'Collage',
              labelStyle: Styles.font14w500,
              controller: TextEditingController(),
            ),
            ChoosePositionButton(value: 'student', onChange: (p0) {}),
            CustomTextField(
              validator: (value) {
                // if (bloc.position != 'Student') return null;
                if (value == null || value.isEmpty) {
                  return 'Please enter a number';
                }
                final number = double.tryParse(value);
                if (number == null) {
                  return 'Invalid number';
                }
                if (number > 5) {
                  return 'GPA must be less than or equal to 5';
                }
                return null;
              },
              textInputType: TextInputType.number,
              hintText: "GPA",
              labelText: 'GPA',
              labelStyle: Styles.font14w500,
              controller: TextEditingController(),
            ),
            CustomTextField(
              validator: (value) {
                // if (bloc.position != 'Student') return null;
                if (value == null || value.isEmpty) {
                  return 'Please enter a number';
                }
                final number = double.tryParse(value);
                if (number == null) {
                  return 'Invalid number';
                }
                return null;
              },
              textInputType: TextInputType.number,
              hintText: "Level",
              labelText: 'Level',
              labelStyle: Styles.font14w500,
              controller: TextEditingController(),
            ),
            CustomAppButton(
              margin: EdgeInsets.only(top: 20.h),
              onTap: () {},
              label: "Save Changes",
              textStyle: Styles.font16w700.copyWith(color: ColorsManager.whiteColor),
              width: 260.w,
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
