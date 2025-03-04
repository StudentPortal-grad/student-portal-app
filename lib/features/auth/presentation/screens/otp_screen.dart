import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import '../../../../core/loading/view/loading_dialog.dart';
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

  // todo: don't forget test with forget password while integration with backend

  final bool? isForgetPassword;
  final String email;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  String pinCode = '';
  late final TextEditingController pinController;

  /// todo timer to resend

  @override
  void initState() {
    pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    pinCode = '';
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
          if (state is OtpLoading || state is ResendEmailLoading) {
            LoadingDialog.showLoadingDialog(context);
          } else {
            LoadingDialog.hideLoadingDialog();
          }

          if (state is OtpFailure) {
            CustomToast(context).showErrorToast(message: state.error.name);
          }

          if (state is ResendEmailFailure) {
            CustomToast(context).showErrorToast(message: state.error.name);
          }
          if (state is OtpSuccess) {
            CustomToast(context).showSuccessToast(message: 'Email Verified');
            if (widget.isForgetPassword == false) {
              AppRouter.clearAndNavigate(AppRouter.homeView);
            } else {
              AppRouter.router.pushReplacement(AppRouter.setNewPassword);
            }
          }

          if (state is ResendEmailSuccess || state is SendOtpSuccess) {
            CustomToast(context).showSuccessToast(message: "Email was sent");
          }
        },
        builder: (context, state) {
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
                padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 30.h),
                child: Column(
                  children: [
                    Text(
                      "We’ve sent an OTP code to your email",
                      style: Styles.font16w500.copyWith(fontWeight: FontWeight.w400,color: ColorsManager.grayColor2),
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
                      codeController: pinController,
                      onChange: (value) {
                        pinCode = value;
                        log('pinCode: $pinCode');
                        setState(() {});
                      },
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
                            context
                                .read<OtpBloc>()
                                .add(ResendEmail(email: widget.email));
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
                        activeButton: pinCode.length == 4,
                        label: "Continue",
                        textStyle: Styles.font16w700.copyWith(color: ColorsManager.whiteColor),
                        width: 260.w,
                        height: 40.h,
                        onTap: () {

                          return;
                          if (widget.isForgetPassword == false) {
                            context.read<OtpBloc>().add(
                                  VerifyEmail(
                                    pinCode: pinCode,
                                    email: widget.email,
                                  ),
                                );
                          } else {
                            context.read<OtpBloc>().add(
                                  SendOtpForgetPassword(
                                    pinCode: pinCode,
                                    email: widget.email,
                                  ),
                                );
                          }
                        },
                      ),
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
