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

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        end: 20.w,
        top: 22.5.h,
      ),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bloc = context.read<LoginBloc>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTitle(
                title: 'Log In',
              ),
              58.heightBox,
              CustomTextField(
                maxLines: 1,
                labelText: 'Email',
                hintText: "Please Enter Your Email",
                controller: bloc.emailController,
                validator: (value) => AppRegex.validateEmail(value),
                textInputType: TextInputType.emailAddress,
                onChanged: (value) => bloc.add(LoginValidation()),
              ),
              20.heightBox,
              CustomTextField(
                controller: bloc.passwordController,
                labelText: 'Password',
                hintText: "Please Enter Your Password",
                validator: (value) => AppRegex.validatePassword(value),
                maxLines: 1,
                textInputType: TextInputType.visiblePassword,
                onChanged: (value) => bloc.add(LoginValidation()),
                obscureText: true,
                showSuffixIcon: true,
              ),
              16.heightBox,
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () =>
                      AppRouter.router.push(AppRouter.forgetPasswordView),
                  child: Text(
                    "Forgot Password?",
                    style: Styles.font14w500
                        .copyWith(color: ColorsManager.textColor),
                  ),
                ),
              ),
              32.heightBox,
              BlocSelector<LoginBloc, LoginState, bool>(
                selector: (state) {
                  bool isValid = false;
                  if (state is LoginValidationState) {
                    isValid = (state.isEmailValid == true &&
                        state.isPasswordSecure == true);
                  }
                 return isValid;
                },
                builder: (context, isValid) {
                  return Center(
                    child: CustomAppButton(
                      loading: state is LogInLoading,
                      activeButton: isValid,
                      onTap: () {
                        bloc.add(LoginRequested(
                          email: bloc.emailController.text,
                          password: bloc.passwordController.text,
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
          );
        },
      ),
    );
  }
}
