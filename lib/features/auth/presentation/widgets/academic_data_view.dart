import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class AcademicDataView extends StatelessWidget {
  const AcademicDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(title: "Academic Data".make(style: Styles.font20w600)),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              spacing: 20.h,
              children: [
                CustomTextField(
                  textInputType: TextInputType.name,
                  hintText: "University",
                  labelText: 'University',
                  labelStyle: Styles.font14w500,
                  controller: TextEditingController(text: ''),
                ),
                CustomTextField(
                  textInputType: TextInputType.name,
                  hintText: "Collage",
                  labelText: 'Collage',
                  labelStyle: Styles.font14w500,
                  controller: TextEditingController(text: ''),
                ),
                ChoosePositionButton(),
                CustomTextField(
                  textInputType: TextInputType.number,
                  hintText: "GPA",
                  labelText: 'GPA',
                  labelStyle: Styles.font14w500,
                  controller: TextEditingController(text: ''),
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

class ChoosePositionButton extends StatelessWidget {
  const ChoosePositionButton({super.key, this.value, this.onChange});

  final String? value;
  final Function(String)? onChange;
  static List<String> options = ['students', 'professors', 'graduates', 'other'];

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButton<String>(
      hintText: 'Select Position',
      labelText: 'Position',
      labelStyle: Styles.font14w500,
      value: value,
      items: List.generate(
        options.length,
        (index) => DropdownMenuItem(
          value: options[index].toLowerCase(),
          child: Text(options[index]),
        ),
      ),
      onChanged: (p0) {
        if (onChange != null) {
          onChange!(p0 ?? '');
        }
      },
    );
  }
}
