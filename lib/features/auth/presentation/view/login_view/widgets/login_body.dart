import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/functions/validation.dart';

import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/widgets/auth_title.dart';
import '../../../../../../core/widgets/custom_app_button.dart';
import '../../../../../../core/widgets/custom_login_signup_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../mange/login_bloc/login_bloc.dart';
import '../../../mange/login_bloc/login_event.dart';
import '../../../mange/login_bloc/login_state.dart';

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
                validator: (value) => Validation.validateEmail(value),
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
                validator: (value) => Validation.validatePassword(value),
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
                style: TextStyle(color: Color(0xff33384B), fontSize: 15.sp),
              ),
            ),
          ),
          SizedBox(height: 32.h),
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
                  label: "Log In",
                  width: 260.w,
                ),
              );
            },
          ),
          SizedBox(height: 32.h),
          const CustomLoginSignupButton(isLogin: true),
        ],
      ),
    );
  }
}
