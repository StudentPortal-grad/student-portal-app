import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';

import '../../../../core/loading/view/loading_dialog.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/helpers/custom_toast.dart';
import '../manager/set_new_password/set_new_password_bloc.dart';
import '../manager/set_new_password/set_new_password_event.dart';
import '../manager/set_new_password/set_new_password_state.dart';

class SetNewPassword extends StatelessWidget {
  const SetNewPassword({super.key});

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
          final bloc = context.read<SetNewPasswordBloc>();
          return PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: ColorsManager.whiteColor,
              appBar: CustomAppBar(
                title: Text(
                  'Set New Password',
                  style: Styles.font20w600,
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
                          controller: bloc.passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'New Password',
                          hintText: "Please Enter New Password",
                          onChanged: (value) {
                            bloc.add(
                              PasswordStrengthChecked(password: value),
                            );
                            bloc.add(
                              ConfirmPasswordChecked(
                                password: bloc.passwordController.text,
                                confirmPassword:
                                    bloc.confirmPasswordController.text,
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
                          controller: bloc.confirmPasswordController,
                          textInputType: TextInputType.visiblePassword,
                          showSuffixIcon: true,
                          obscureText: true,
                          labelText: "Confirm Password",
                          hintText: "Please Enter New Password Again",
                          onChanged: (value) {
                            context.read<SetNewPasswordBloc>().add(
                                  ConfirmPasswordChecked(
                                    password: bloc.passwordController.text,
                                    confirmPassword: value,
                                  ),
                                );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 32.h),
                    BlocSelector<SetNewPasswordBloc, SetNewPasswordState, bool>(
                      selector: (state) {
                        if (state is SetNewPasswordConfirmed) {
                          return state.isMatching;
                        }
                        return false;
                      },
                      builder: (context, isMatching) {
                        return CustomAppButton(
                          loading: state is SetNewPasswordLoading,
                          activeButton: isMatching,
                          onTap: () {
                            // AppRouter.clearAndNavigate(AppRouter.homeView);
                            // bloc.add(
                            //       SetNewPasswordRequested(
                            //         password: passwordController.text,
                            //       ),
                            //     );
                          },
                          label: "Confirm",
                          textStyle: Styles.font16w700
                              .copyWith(color: ColorsManager.whiteColor),
                          width: 260.w,
                          height: 40.h,
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
