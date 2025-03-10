import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/utils/app_router.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/custom_toast.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../profile/data/dto/change_password_dto.dart';
import '../../../profile/presentation/manager/profile_bloc/profile_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            CustomToast(context).showSuccessToast(message: state.message);
            AppRouter.router.pop();
          }
          if (state is ChangePasswordFailureState) {
            CustomToast(context).showErrorToast(message: state.failure.message);
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<ProfileBloc>(context);
          return Scaffold(
            backgroundColor: ColorsManager.backgroundColorLight,
            appBar: CustomAppBar(
              backgroundColor: ColorsManager.backgroundColorLight,
              title: 'Set New Password'.make(style: Styles.font20w600),
            ),
            body: Form(
              key: bloc.changePasswordFormKey,
              child: SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(
                    start: 20.w, end: 20.w, top: 30.h),
                child: Column(
                  spacing: 32.h,
                  children: [
                    CustomTextField(
                      maxLines: 1,
                      validator: (value) => AppRegex.validatePassword(value),
                      controller: bloc.currentPasswordController,
                      textInputType: TextInputType.visiblePassword,
                      labelText: 'Current Password',
                      hintText: "Please Enter Current Password",
                      showSuffixIcon: true,
                      obscureText: true,
                    ),
                    CustomTextField(
                      maxLines: 1,
                      validator: (value) => AppRegex.validatePassword(value),
                      controller: bloc.newPasswordController,
                      textInputType: TextInputType.visiblePassword,
                      labelText: 'New Password',
                      hintText: "Please Enter New Password",
                      showSuffixIcon: true,
                      obscureText: true,
                    ),
                    CustomTextField(
                      maxLines: 1,
                      controller: bloc.confirmPasswordController,
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value != bloc.newPasswordController.text) {
                          return "Password doesn't match with new password!";
                        }
                        return null;
                      },
                      showSuffixIcon: true,
                      obscureText: true,
                      labelText: "Confirm Password",
                      hintText: "Please Enter New Password Again",
                    ),
                    CustomAppButton(
                      loading: state is ChangePasswordLoadingState,
                      onTap: () {
                        if (!bloc.changePasswordFormKey.currentState!
                            .validate()) {
                          return;
                        }
                        bloc.add(
                          ChangePasswordEvent(
                              changePasswordDto: ChangePasswordDto(
                            currentPassword:
                                bloc.currentPasswordController.text,
                            newPassword: bloc.newPasswordController.text,
                          )),
                        );
                      },
                      label: "Save",
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
