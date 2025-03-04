import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/signup_bloc/signup_bloc.dart';
import '../manager/signup_bloc/signup_state.dart';
import 'choose_gender_button.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        // final bloc = context.read<SignupBloc>();
        return SingleChildScrollView(
          padding:
              EdgeInsetsDirectional.only(top: 65.h, start: 20.w, end: 20.w),
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
              ChooseGenderButton(
                onChange: (value) {
                  // context.read<SignupBloc>().add(GenderSelected(value: value));
                },
                value: 'male',
              ),

              SizedBox(height: 20.h),

              /// **Select Date of Birth**
              CustomTextField(
                textInputType: TextInputType.none,
                hintText: "Date of Birth",
                borderColor: const Color(0xff3c3e36),
                showCursor: false,
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
        );
      },
    );
  }
}
