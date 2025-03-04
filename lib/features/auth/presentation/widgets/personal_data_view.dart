import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';

import '../../../../core/helpers/file_service.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_phone_number_input.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'choose_gender_button.dart';

class PersonalDataView extends StatefulWidget {
  const PersonalDataView({super.key});

  @override
  State<PersonalDataView> createState() => _PersonalDataViewState();
}

class _PersonalDataViewState extends State<PersonalDataView> {
  String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(title: "Personal Data".make(style: Styles.font20w600)),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              spacing: 20.h,
              children: [
                CustomImageView(
                  width: 100.w,
                  height: 100.h,
                  circle: true,
                  onTap: () async {
                    profileImage = (await FileService.pickImage())?.path;
                    setState(() {});
                  },
                  imagePath: profileImage ?? AssetsApp.pickImage,
                ),
                ChooseGenderButton(
                  onChange: (value) {
                    // context.read<SignupBloc>().add(GenderSelected(value: value));
                  },
                  // value: 'male',
                ),
                CustomTextField(
                  textInputType: TextInputType.name,
                  hintText: "User Name",
                  labelText: 'User Name',
                  labelStyle: Styles.font14w500,
                  controller: TextEditingController(text: ''),
                ),
                CustomPhoneNumberInput(
                  phoneController: TextEditingController(),
                  labelText: 'Phone Number',
                  labelStyle: Styles.font14w500,
                ),
                CustomTextField(
                  textInputType: TextInputType.none,
                  hintText: "Date of Birth",
                  labelText: 'Date of Birth',
                  labelStyle: Styles.font14w500,
                  showCursor: false,
                  controller: TextEditingController(text: ''),
                  suffix: Icon(Icons.calendar_month_rounded),
                  onTap: () async {
                    DateTime? birthData = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (birthData != null) {
                      // context.read<SignupBloc>().add(DateOfBirthSelected(
                      //   dateOfBirth: DateFormat("yyyy-MM-dd").format(birthData),
                      // ));
                    }
                  },
                ),
                CustomAppButton(
                  margin: EdgeInsets.only(top: 20.h),
                  onTap: () {},
                  label: "Next",
                  textStyle: Styles.font16w700
                      .copyWith(color: ColorsManager.whiteColor),
                  width: 260.w,
                  height: 40.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
