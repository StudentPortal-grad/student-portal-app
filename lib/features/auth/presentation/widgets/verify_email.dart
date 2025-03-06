import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/features/auth/presentation/manager/signup_bloc/signup_bloc.dart';
import 'package:student_portal/features/auth/presentation/manager/signup_bloc/signup_event.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/widgets/custom_app_button.dart';
import '../../../../../../core/widgets/custom_pin_code_fields.dart';
import '../../../../core/helpers/custom_toast.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../manager/signup_bloc/signup_state.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late Timer _timer;
  int remainingTime = 59; // Initial countdown time in seconds

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the countdown when the screen loads
  }

  // Function to start the countdown timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        _timer.cancel(); // Stop the timer when countdown reaches 0
      }
    });
  }

  restartTimer() {
    setState(() {
      remainingTime = 59; // Reset the timer when OTP is resent
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Ensure timer is disposed to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if(state is EmailVerificationSuccess){
          CustomToast(context).showSuccessToast(message: 'Email verified successfully');
          context.read<SignupBloc>().nextPage();
        }
        if(state is EmailVerificationFailure){
          CustomToast(context).showErrorToast(message: state.error.message);
        }
        if(state is ResendCodeSuccess) {
          CustomToast(context).showSuccessToast(message: 'OTP resent successfully');
          restartTimer();
        }
      },
      builder: (context, state) {
        final bloc = context.read<SignupBloc>();
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
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
                        UserRepository.user?.email ?? bloc.emailController.text,
                        style: Styles.font16w500.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      50.heightBox,
                      CustomVerificationCode(
                        onChange: (value) =>
                            bloc.add(OnPinCodeChanged(pinCode: value)),
                      ),
                      32.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Can resend the code in ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xff7D8A95),
                            ),
                          ),
                          InkWell(
                            onTap: remainingTime == 0
                                ? () => bloc.add(ResendCodeRequested(email: bloc.emailController.text))
                                : null,
                            // Disable button if countdown is not over
                            child: Text(
                              remainingTime == 0
                                  ? "resend OTP"
                                  : "$remainingTime s",
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
                      32.heightBox,
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomAppButton(
                          label: "Continue",
                          loading: state is OtpLoading,
                          textStyle: Styles.font16w700
                              .copyWith(color: ColorsManager.whiteColor),
                          width: 260.w,
                          height: 40.h,
                          onTap: () {
                            if (bloc.pinCode.length < 6 || remainingTime == 0) return;
                            bloc.add(
                              VerifyEmailRequested(
                                pinCode: bloc.pinCode,
                                email: bloc.emailController.text,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
