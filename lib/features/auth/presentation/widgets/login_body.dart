import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/auth_title.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_login_signup_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/login_bloc/login_bloc.dart';
import '../manager/login_bloc/login_event.dart';
import '../manager/login_bloc/login_state.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        end: 20.w,
        top: 22.5.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTitle(
            title: 'Log In',
          ),
          SizedBox(height: 58.h),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return CustomTextField(
                maxLines: 1,
                labelText: 'Email',
                hintText: "Please Enter Your Email",
                controller: emailController,
                validator: (value) => AppRegex.validateEmail(value),
                textInputType: TextInputType.emailAddress,
                onChanged: (value) => context
                    .read<LoginBloc>()
                    .add(EmailValidationChecked(email: value)),
              );
            },
          ),
          SizedBox(height: 20.h),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return CustomTextField(
                controller: passwordController,
                labelText: 'Password',
                hintText: "Please Enter Your Password",
                validator: (value) => AppRegex.validatePassword(value),
                maxLines: 1,
                textInputType: TextInputType.visiblePassword,
                onChanged: (value) => context
                    .read<LoginBloc>()
                    .add(PasswordStrengthChecked(password: value)),
                obscureText: true,
                showSuffixIcon: true,
              );
            },
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => AppRouter.router.push(AppRouter.forgetPasswordView),
              child: Text(
                "Forgot Password?",
                style: Styles.font14w500.copyWith(color: ColorsManager.textColor),
              ),
            ),
          ),
          32.heightBox,
          BlocSelector<LoginBloc, LoginState, bool>(
            selector: (state) {
              if (state is LoadingPasswordCheckerState) {
                return state.isPasswordSecure;
              } else if (state is LoadingEmailValidationState) {
                return state.isEmailValid;
              }
              return false;
            },
            builder: (context, isValid) {
              return Center(
                child: CustomAppButton(
                  activeButton: isValid,
                  onTap: () {
                    context.read<LoginBloc>().add(LoginRequested(
                          email: emailController.text,
                          password: passwordController.text,
                        ));
                  },
                  label: "Confirm",
                  textStyle: Styles.font16w700
                      .copyWith(color: ColorsManager.whiteColor),
                  width: 260.w,
                  height: 40.h,
                ),
              );
            },
          ),
          32.heightBox,
          const CustomLoginSignupButton(isLogin: true),
        ],
      ),
    );
  }
}
