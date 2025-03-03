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


class SignupBody extends StatefulWidget {
  const SignupBody({super.key, this.nextPage});

  final Function()? nextPage;

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
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthTitle(title: 'Sign Up'),
            50.heightBox,
            CustomTextField(
              controller: fullNameController,
              labelText: 'Full Name',
              textInputType: TextInputType.name,
              onChanged: (value) {
                //todo : check if name is valid
              },
              hintText: "Please Enter Your Full name",
            ),
            15.heightBox,
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
            40.heightBox,
            Center(
              child: CustomAppButton(
                activeButton: true,
                onTap: () {
                  widget.nextPage?.call();
                  return;
                  //
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
                textStyle:
                    Styles.font16w700.copyWith(color: ColorsManager.whiteColor),
                width: 260.w,
                height: 40.h,
              ),
            ),
            SizedBox(height: 30.h),
            const CustomLoginSignupButton(isLogin: false),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
