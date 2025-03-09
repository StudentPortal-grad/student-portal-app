import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColorLight,
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.backgroundColorLight,
        title: 'Set New Password'.make(style: Styles.font20w600),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 30.h),
        child: Column(
          spacing: 32.h,
          children: [
            CustomTextField(
              maxLines: 1,
              controller: TextEditingController(),
              textInputType: TextInputType.visiblePassword,
              labelText: 'Current Password',
              hintText: "Please Enter Current Password",
              onChanged: (value) {},
              showSuffixIcon: true,
              obscureText: true,
            ),
            CustomTextField(
              maxLines: 1,
              controller: TextEditingController(),
              textInputType: TextInputType.visiblePassword,
              labelText: 'New Password',
              hintText: "Please Enter New Password",
              onChanged: (value) {},
              showSuffixIcon: true,
              obscureText: true,
            ),
            CustomTextField(
              maxLines: 1,
              controller: TextEditingController(),
              textInputType: TextInputType.visiblePassword,
              showSuffixIcon: true,
              obscureText: true,
              labelText: "Confirm Password",
              hintText: "Please Enter New Password Again",
              onChanged: (value) {},
            ),
            CustomAppButton(
              onTap: () {},
              label: "Save",
            ),
          ],
        ),
      ),
    );
  }
}
