import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';

import '../../../../../core/loading/view/loading_dialog.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/assets_app.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_app_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/custom_toast.dart';
import '../../mange/set_new_password/set_new_password_bloc.dart';
import '../../mange/set_new_password/set_new_password_event.dart';
import '../../mange/set_new_password/set_new_password_state.dart';
import '../login_view/widgets/custom_checker_data_view.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetNewPasswordBloc(),
      child: BlocConsumer<SetNewPasswordBloc, SetNewPasswordState>(
        listener: (context, state) {
          if (state is SetNewPasswordLoading) {
            LoadingDialog.showLoadingDialog(context);
          } else {
            LoadingDialog.hideLoadingDialog();
          }
          if (state is SetNewPasswordFailure) {
            CustomToast(context).showErrorToast(message: state.error.error);
          }
          if (state is SetNewPasswordSuccess) {
            CustomToast(context)
                .showSuccessToast(message: "Set New Password Successfully");
            AppRouter.clearAndNavigate(AppRouter.loginView);
          }
        },
        builder: (context, state) {
          return PopScope(
            canPop: false,
            child: Scaffold(
              appBar: CustomAppBar(
                title: Text(
                  'Set New Password',
                  style: Styles.title.copyWith(
                    color: Color(0xff33384B),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(
                  start: 20.w,
                  end: 20.w,
                  top: 50.h,
                ),
                child: Column(
                  children: [
                    BlocBuilder<SetNewPasswordBloc, SetNewPasswordState>(
                      builder: (context, state) {
                        return CustomTextField(
                          maxLines: 1,
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'New Password',
                          hintText: "Please Enter New Password",
                          onChanged: (value) {
                            context.read<SetNewPasswordBloc>().add(
                                  PasswordStrengthChecked(password: value),
                                );
                            context.read<SetNewPasswordBloc>().add(
                                  ConfirmPasswordChecked(
                                    password: passwordController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
                                  ),
                                );
                          },
                          showSuffixIcon: true,
                          obscureText: true,
                        );
                      },
                    ),
                    SizedBox(height: 32.h),
                    BlocBuilder<SetNewPasswordBloc, SetNewPasswordState>(
                      builder: (context, state) {
                        return CustomTextField(
                          maxLines: 1,
                          controller: confirmPasswordController,
                          textInputType: TextInputType.visiblePassword,
                          showSuffixIcon: true,
                          obscureText: true,
                          labelText: "Confirm Password",
                          hintText: "Please Enter New Password Again",
                          onChanged: (value) {
                            context.read<SetNewPasswordBloc>().add(
                                  ConfirmPasswordChecked(
                                    password: passwordController.text,
                                    confirmPassword: value,
                                  ),
                                );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 32.h),
                    BlocSelector<SetNewPasswordBloc, SetNewPasswordState,
                        bool>(
                      selector: (state) {
                        if (state is SetNewPasswordConfirmed) {
                          return state.isMatching;
                        }
                        return false;
                      },
                      builder: (context, isMatching) {
                        return CustomAppButton(
                          activeButton: isMatching,
                          onTap: () {
                            context.read<SetNewPasswordBloc>().add(
                                  SetNewPasswordRequested(
                                    password: passwordController.text,
                                  ),
                                );
                          },
                          label: "Confirm",
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
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
