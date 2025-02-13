import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/widgets/auth_title.dart';
import '../../../../../../core/helpers/app_regex.dart';
import '../../../../../../core/widgets/custom_app_button.dart';
import '../../../../../../core/widgets/custom_login_signup_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_toast.dart';
import '../../../../data/dto/signup_request/signup_request.dart';
import '../../../mange/signup_bloc/signup_bloc.dart';
import '../../../mange/signup_bloc/signup_event.dart';
import '../../../mange/signup_bloc/signup_state.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  late final TextEditingController emailController;
  late final TextEditingController fullNameController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    fullNameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          CustomToast(context).showSuccessToast(
            message: "Process Done Successfully",
          );
        }
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 20.w,
          end: 20.w,
          top: 60.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTitle(title: 'Sign Up'),
              SizedBox(height: 56.h),
              CustomTextField(
                controller: fullNameController,
                labelText: 'Full Name',
                textInputType: TextInputType.name,
                onChanged: (value) {
                  //todo : check if name is valid
                },
                hintText: "Please Enter Your Full name",
              ),
              SizedBox(height: 15.h),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    labelText: "Email",
                    hintText: "Please Enter Your Email",
                    onChanged: (value) {
                      // todo : check if email is valid
                    },
                    validator: (value) => AppRegex.validateEmail(value),
                  );
                },
              ),
              SizedBox(height: 40.h),
              Center(
                child: CustomAppButton(
                  activeButton: true,
                  onTap: () {
                    context.read<SignupBloc>().add(
                          SignupRequested(
                            signupRequest: SignupRequest(
                              email: emailController.text,
                              password: passwordController.text,
                              fullName: fullNameController.text,
                            ),
                          ),
                        );
                  },
                  label: "Sign Up",
                  width: 260.w,
                ),
              ),
              SizedBox(height: 30.h),
              const CustomLoginSignupButton(isLogin: false),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
/*
              SizedBox(height: 15.h),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return CustomTextField(
                    maxLines: 1,
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    onChanged: (value) =>
                        context.read<SignupBloc>().add(PasswordStrengthChecked(password: value)),
                    hintText: "Password",
                    obscureText: true,
                    showSuffixIcon: true,
                    prefixIcon: SvgPicture.asset(
                      AssetsApp.lockIcon,
                      fit: BoxFit.none,
                    ),
                    filledColor: const Color(0xff2C2C2E),
                  );
                },
              ),
              SizedBox(height: 15.h),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return CustomTextField(
                    maxLines: 1,
                    controller: confirmPasswordController,
                    textInputType: TextInputType.visiblePassword,
                    showSuffixIcon: true,
                    onChanged: (value) => context.read<SignupBloc>().add(
                      ConfirmPasswordChecked(
                        password: passwordController.text,
                        confirmPassword: value,
                      ),
                    ),
                    obscureText: true,
                    hintText: "Confirm Password",
                    prefixIcon: SvgPicture.asset(
                      AssetsApp.lockIcon,
                      fit: BoxFit.none,
                    ),
                    filledColor: const Color(0xff2C2C2E),
                  );
                },
              ),
             */
