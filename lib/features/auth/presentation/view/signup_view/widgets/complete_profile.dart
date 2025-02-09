import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/utils/assets_app.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/widgets/custom_app_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../mange/signup_bloc/signup_bloc.dart';
import '../../../mange/signup_bloc/signup_state.dart';
import 'choose_gender_button.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            top: 65.h,
            start: 20.w,
            end: 20.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AssetsApp.logo, height: 80.h),
                SizedBox(height: 20.h),
                Text(
                  "Let’s complete your profile",
                  style: Styles.font22w700,
                ),
                SizedBox(height: 15.h),
                Text(
                  "It will help us to know more about you!",
                  style: Styles.font12w400,
                ),
                SizedBox(height: 30.h),

                /// **Choose Gender**
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    // final String? gender = (state is SignupProfileUpdated) ? state.gender : null;
                    return ChooseGenderButton(
                      onChanged: (value) {
                        // context.read<SignupBloc>().add(GenderSelected(value: value));
                      },
                      value: 'male',
                      prefixIcon: SvgPicture.asset(
                        AssetsApp.genderIcon,
                        fit: BoxFit.none,
                      ),
                    );
                  },
                ),

                SizedBox(height: 20.h),

                /// **Select Date of Birth**
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    // final birthDate = (state is SignupProfileUpdated) ? state.birthDate : "";
                    return CustomCalenderField(
                      controller: TextEditingController(text: ''),
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
                    );
                  },
                ),

                SizedBox(height: 30.h),

                /// **Continue Button**
                BlocSelector<SignupBloc, SignupState, bool>(
                  selector: (state) {
                    // if (state is SignupProfileUpdated) {
                    //   return state.isProfileComplete;
                    // }
                    return false;
                  },
                  builder: (context, isProfileComplete) {
                    return CustomAppButton(
                      width: 220.w,
                      activeButton: isProfileComplete,
                      label: "Continue",
                      onTap: () {
                        // context.read<SignupBloc>().add(OnPageChanged(value: 3)); // Navigate to next page
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomFieldWithUtil extends StatelessWidget {
  const CustomFieldWithUtil({
    super.key,
    required this.controller,
    required this.unit,
    required this.hintText,
    required this.iconPath,
    this.onChanged,
    this.onUnitTap,
  });

  final TextEditingController controller;
  final String unit, hintText, iconPath;
  final Function(dynamic value)? onChanged;
  final Function()? onUnitTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size.width * 0.7,
          child: CustomTextField(
            controller: controller,
            hintText: hintText,
            onChanged: (value) => onChanged!(value) ?? () {},
            textInputType: TextInputType.number,
            prefixIcon: SvgPicture.asset(
              iconPath,
              fit: BoxFit.none,
            ),
          ),
        ),
        InkWell(
          onTap: onUnitTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            width: 40.h,
            height: 40.h,
            decoration: BoxDecoration(
              color: ColorsManager.mainColor,
              borderRadius: BorderRadius.all(
                Radius.circular(14.r),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              unit,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CustomCalenderField extends StatelessWidget {
  const CustomCalenderField({
    super.key,
    required this.controller,
    this.onChanged,
    required this.onTap,
  });

  final TextEditingController controller;
  final Function(dynamic value)? onChanged;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      onChanged: (value) {
        return onChanged!(value) ?? () {};
      },
      textInputType: TextInputType.none,
      hintText: "Date of Birth",
      borderColor: const Color(0xff3c3e36),
      showCursor: false,
      prefixIcon: SvgPicture.asset(
        AssetsApp.calenderIcon,
        fit: BoxFit.none,
      ),
      onTap: onTap,
    );
  }
}
