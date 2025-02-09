import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/features/auth/presentation/mange/login_bloc/login_state.dart';

import '../../../../../../contestants.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/widgets/custom_app_button.dart';
import '../../../../../../core/widgets/custom_pin_code_fields.dart';
import '../../../../../../core/widgets/custom_toast.dart';
import '../../../mange/signup_bloc/signup_bloc.dart';
import '../../../mange/signup_bloc/signup_event.dart';
import '../../../mange/signup_bloc/signup_state.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  String pinCode = '';
  late final TextEditingController pinController;

  @override
  void initState() {
    pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is LoadingEmailValidationState) {
          CustomToast(context).showLoadingToast();
        }
        if (state is ResendCodeSuccess) {
          CustomToast(context).showSuccessToast(message: 'Resend Successfully');
        }
        if (state is EmailVerificationSuccess) {
          CustomToast(context).showSuccessToast(message: "Verify Successfully");
          // cubit.signupController.nextPage(
          //   duration: kNavDuration,
          //   curve: Curves.linear,
          // );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: kHorizontal.w,
            end: kHorizontal.w,
            top: 150.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verify your email",
                  style: Styles.font22w700.copyWith(fontSize: 28.sp),
                ),
                SizedBox(height: 15.h),
                Text(
                  " Please fill the code to confirm your email",
                  style: Styles.font12w400.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 5.h),
                Text(
                  " ${UserRepository.user?.email ?? ''}",
                  style: Styles.font12w400
                      .copyWith(fontSize: 12.sp, color: ColorsManager.mainColor),
                ),
                SizedBox(height: 25.h),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff2a2a2c),
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                  ),
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: 10.h, left: 20.w, right: 20.w),
                  child: CustomVerificationCode(
                    codeController: pinController,
                    backgroundColor: const Color(0xffaaaaaa),
                    onChange: (value) {
                      pinCode = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      context.read<SignupBloc>().add(ResendCodeRequested(
                          email: UserRepository.user?.email ?? ''));
                    },
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManager.mainColor,
                        color: ColorsManager.mainColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomAppButton(
                    width: 220.w,
                    activeButton: pinCode.length == 5,
                    label: "Continue",
                    onTap: () {
                      context.read<SignupBloc>().add(VerifyEmailRequested(
                          pinCode: pinCode,
                          email: UserRepository.user?.email ?? ''));
                    },
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
