import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/auth/presentation/manager/signup_bloc/signup_bloc.dart';
import 'package:student_portal/features/auth/presentation/manager/signup_bloc/signup_event.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/widgets/custom_app_button.dart';
import '../../../../../../core/widgets/custom_pin_code_fields.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../manager/signup_bloc/signup_state.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        final bloc = context.read<SignupBloc>();
        return SingleChildScrollView(
          child: Column(
            children: [
              10.heightBox,
              CustomAppBar(
                leadingOnTap: () => bloc.previousPage(),
                title: Text(
                  'Verify Email',
                  style: Styles.font22w700.copyWith(
                    color: Color(0xff33384B),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    35.heightBox,
                    Text(
                      "We’ve sent an OTP code to your email",
                      style: Styles.font16w500.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorsManager.grayColor2),
                    ),
                    3.heightBox,
                    Text(
                      "mina1062016665@gmail.com",
                      style: Styles.font16w500.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    50.heightBox,
                    CustomVerificationCode(
                      onChange: (value) => bloc.add(OnPinCodeChanged(pinCode: value)),
                    ),
                    32.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Can resend the code in',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xff7D8A95),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // context
                            //     .read<OtpBloc>()
                            //     .add(ResendEmail(email: widget.email));
                          },
                          child: Text(
                            " 59 s",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorsManager.mainColor,
                              color: ColorsManager.mainColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomAppButton(
                        // activeButton: pinCode.length == 4,
                        label: "Continue",
                        textStyle: Styles.font16w700
                            .copyWith(color: ColorsManager.whiteColor),
                        width: 260.w,
                        height: 40.h,
                        onTap: () {
                          bloc.nextPage();
                          return;
                          // if (widget.isForgetPassword == false) {
                          //   context.read<OtpBloc>().add(
                          //     VerifyEmail(
                          //       pinCode: pinCode,
                          //       email: widget.email,
                          //     ),
                          //   );
                          // } else {
                          //   context.read<OtpBloc>().add(
                          //     SendOtpForgetPassword(
                          //       pinCode: pinCode,
                          //       email: widget.email,
                          //     ),
                          //   );
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
