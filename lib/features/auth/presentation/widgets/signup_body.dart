import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/widgets/auth_title.dart';
import '../../../../../../core/helpers/app_regex.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/widgets/custom_app_button.dart';
import '../../../../../../core/widgets/custom_login_signup_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/helpers/custom_toast.dart';
import '../../data/dto/signup_request.dart';
import '../manager/signup_bloc/signup_bloc.dart';
import '../manager/signup_bloc/signup_event.dart';
import '../manager/signup_bloc/signup_state.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key, });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          CustomToast(context).showSuccessToast(
            message: state.signupResponse.message ?? 'Signup Successfully',
          );
          context.read<SignupBloc>().nextPage();
        }
      },
      builder: (context, state) {
        final bloc = context.read<SignupBloc>();
        return SingleChildScrollView(
          padding:
              EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 60.h),
          child: Form(
            key: bloc.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthTitle(title: 'Sign Up'),
                50.heightBox,
                CustomTextField(
                  controller: bloc.fullNameController,
                  labelText: 'Full Name',
                  textInputType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  hintText: "Please Enter Your Full name",
                ),
                18.heightBox,
                CustomTextField(
                  controller: bloc.emailController,
                  textInputType: TextInputType.emailAddress,
                  labelText: "Email",
                  hintText: "Please Enter Your Email",
                  validator: (value) => AppRegex.validateEmail(value),
                ),
                18.heightBox,
                CustomTextField(
                  controller: bloc.passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) => AppRegex.validatePassword(value),
                  hintText: "Please Enter Your Password",
                ),
                18.heightBox,
                CustomTextField(
                  controller: bloc.confirmPasswordController,
                  labelText: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value != bloc.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  textInputType: TextInputType.visiblePassword,
                  hintText: "Please Confirm Your Password",
                ),
                40.heightBox,
                Center(
                  child: CustomAppButton(
                    activeButton: true,
                    loading: state is SignupLoading,
                    onTap: () {
                      bloc.add(
                            SignupRequested(
                              signupRequest: SignupDTO(
                                email: bloc.emailController.text,
                                password: bloc.passwordController.text,
                                fullName: bloc.fullNameController.text,
                              ),
                            ),
                          );
                    },
                    label: "Sign Up",
                    textStyle: Styles.font16w700
                        .copyWith(color: ColorsManager.whiteColor),
                    width: 260.w,
                    height: 40.h,
                  ),
                ),
                20.heightBox,
                const CustomLoginSignupButton(isLogin: false),
              ],
            ),
          ),
        );
      },
    );
  }
}
