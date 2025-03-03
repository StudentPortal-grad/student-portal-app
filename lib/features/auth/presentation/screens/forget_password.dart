import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/loading/view/loading_dialog.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/helpers/custom_toast.dart';
import '../manager/forget_password_bloc/forget_password_bloc.dart';
import '../manager/forget_password_bloc/forget_password_event.dart';
import '../manager/forget_password_bloc/forget_password_state.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late final TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordBloc(),
      child: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) {
          log('state: $state');
          if (state is ForgetPasswordLoading) {
            LoadingDialog.showLoadingDialog(context);
          } else {
            LoadingDialog.hideLoadingDialog();
          }
          if (state is ForgetPasswordFailure) {
            CustomToast(context).showErrorToast(message: state.error.error);
          }
          if (state is ForgetPasswordSuccess) {
            CustomToast(context).showSuccessToast(message: "Email was sent");
            AppRouter.router.pushReplacement(
              AppRouter.otpView,
              extra: {
                "email": emailController.text,
                'isForgetPassword': true,
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              title: Text(
                'Set Password',
                style: Styles.font20w600,
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  25.heightBox,
                  BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                    builder: (context, state) {
                      return CustomTextField(
                        controller: emailController,
                        labelText: 'Email',
                        validator: (value) => AppRegex.validateEmail(value),
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Please Enter Your Email',
                        onChanged: (value) {
                          context
                              .read<ForgetPasswordBloc>()
                              .add(ForgetPasswordEmailValidation(email: value));
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "A link will be delivered to your email address",
                    style: Styles.font14w400.copyWith(),
                  ),
                  const SizedBox(height: 40),
                  BlocSelector<ForgetPasswordBloc, ForgetPasswordState, bool>(
                    selector: (state) {
                      if (state is ForgetPasswordEmailValidated) {
                        return state.validEmail;
                      }
                      return false;
                    },
                    builder: (context, isValidEmail) {
                      return Center(
                        child: CustomAppButton(
                          activeButton: isValidEmail,
                          onTap: () {
                            context.read<ForgetPasswordBloc>().add(
                                  ForgetPasswordRequested(
                                      email: emailController.text),
                                );
                          },
                          label: "Confirm",
                          width: 260.w,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
