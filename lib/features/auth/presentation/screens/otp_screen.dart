import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_pin_code_fields.dart';
import '../../../../core/helpers/custom_toast.dart';
import '../manager/otp_bloc/otp_bloc.dart';
import '../manager/otp_bloc/otp_event.dart';
import '../manager/otp_bloc/otp_state.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key, required this.email, this.isForgetPassword});

  final bool? isForgetPassword;
  final String email;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
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
    return BlocProvider(
      create: (context) {
        final otpBloc = OtpBloc();
        // if (widget.isForgetPassword == false) {
        //   otpBloc.add(SendOtpVerify(email: widget.email));
        // } else {
        //   otpBloc.add(SendOtpForgetPassword(pinCode: "", email: widget.email));
        // }
        return otpBloc;
      },
      child: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          log('state: $state');
         if(state is ResendEmailSuccess) {
           restartTimer();
         }
          if (state is OtpFailure) {
            CustomToast(context).showErrorToast(message: state.error.message);
          }
          if (state is OtpSuccess) {
            CustomToast(context).showSuccessToast(message: 'OTP verified successfully');
            AppRouter.clearAndNavigate(AppRouter.setNewPassword);
          }
        },
        builder: (context, state) {
          final otpBloc = context.read<OtpBloc>();
          return PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBar(
                title: Text(
                  'Enter OTP',
                  style: Styles.font22w700.copyWith(
                    color: Color(0xff33384B),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(
                    start: 20.w, end: 20.w, top: 30.h),
                child: Column(
                  children: [
                    Text(
                      "We’ve sent an OTP code to your email",
                      style: Styles.font16w500.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorsManager.grayColor2),
                    ),
                    3.heightBox,
                    Text(
                      " ${widget.email}",
                      style: Styles.font16w500.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    50.heightBox,
                    CustomVerificationCode(
                      onChange: (value) =>
                          otpBloc.add(OtpCodeChanged(pinCode: value)),
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
                              ? () {
                                  otpBloc.add(ResendEmail(email: widget.email));
                                }
                              : null, // Disable button if countdown is not over
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
                    CustomAppButton(
                      activeButton: true,
                      loading: state is OtpLoading,
                      label: "Continue",
                      textStyle: Styles.font16w700
                          .copyWith(color: ColorsManager.whiteColor),
                      width: 260.w,
                      height: 40.h,
                      onTap: () {
                        if (otpBloc.otpCode.length < 6 || remainingTime == 0) return;
                        otpBloc.add(
                          SendOtpForgetPassword(
                            pinCode: otpBloc.otpCode,
                            email: widget.email,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
