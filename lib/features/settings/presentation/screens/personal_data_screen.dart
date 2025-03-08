import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/core/widgets/custom_phone_number_input.dart';
import 'package:student_portal/features/auth/presentation/widgets/choose_gender_button.dart';

import '../../../../core/helpers/date_picker_helper.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text_field.dart';

class PersonalDataScreen extends StatelessWidget {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColorLight,
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.backgroundColorLight,
        title: 'Personal Data'.make(style: Styles.font20w600),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            20.heightBox,
            ChooseGenderButton(
              value: UserRepository.user?.gender,
              onChange: (p0) {},
            ),
            30.heightBox,
            CustomPhoneNumberInput(
              labelText: 'Phone Number',
              labelStyle: Styles.font14w500,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
              // onInputChanged: (PhoneNumber number) => bloc.phoneNumber = number,
            ),
            30.heightBox,
            CustomTextField(
              textInputType: TextInputType.none,
              hintText: "Date of Birth",
              labelText: 'Date of Birth',
              labelStyle: Styles.font14w500,
              showCursor: false,
              controller: TextEditingController(),
              suffix: Icon(Icons.calendar_month_rounded),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your birthDate';
                }
              },
              onTap: () async {
                DateTime? birthData = await DatePickerHelper.pickDate(context,
                    initialDate: DateTime(2003));
                if (birthData != null) {}
              },
            ),
            30.heightBox,
            CustomAppButton(
              onTap: () {},
              label: "Save Changes",
              textStyle:
                  Styles.font16w700.copyWith(color: ColorsManager.whiteColor),
              width: 260.w,
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
