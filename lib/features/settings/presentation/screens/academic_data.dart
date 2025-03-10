import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/helpers/custom_toast.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/choose_position_button.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../profile/presentation/manager/profile_bloc/profile_bloc.dart';

class AcademicDataScreen extends StatelessWidget {
  const AcademicDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        backgroundColor: ColorsManager.backgroundColorLight,
        appBar: CustomAppBar(
          backgroundColor: ColorsManager.backgroundColorLight,
          title: "Academic Data".make(style: Styles.font20w600),
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccessState) {
              CustomToast(context).showSuccessToast(message: "Profile Updated Successfully");
              AppRouter.router.pop();
            }
            if (state is ProfileFailureState) {
              CustomToast(context).showErrorToast(message: state.failure.message ?? "Unknown Error, Please try again later");
            }
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<ProfileBloc>(context);
            return Form(
              key: bloc.academicFormKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  spacing: 20.h,
                  children: [
                    CustomTextField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your University';
                        }
                        return null;
                      },
                      textInputType: TextInputType.name,
                      hintText: "University",
                      labelText: 'University',
                      labelStyle: Styles.font14w500,
                      controller: bloc.universityController,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your Department';
                        }
                        return null;
                      },
                      textInputType: TextInputType.name,
                      hintText: "Collage",
                      labelText: 'Collage',
                      labelStyle: Styles.font14w500,
                      controller: bloc.collegeController,
                    ),
                    ChoosePositionButton(value: 'student', onChange: (p0) {}),
                    CustomTextField(
                      validator: (value) {
                        if (bloc.position != 'Student') return null;
                        if (value.isEmpty) {
                          return 'Please enter a number';
                        }
                        final number = double.tryParse(value);
                        if (number == null) {
                          return 'Invalid number';
                        }
                        if (number > 5) {
                          return 'GPA must be less than or equal to 5';
                        }
                        return null;
                      },
                      textInputType: TextInputType.number,
                      hintText: "GPA",
                      labelText: 'GPA',
                      labelStyle: Styles.font14w500,
                      controller: bloc.gpaController,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (bloc.position != 'Student') return null;
                        if (value.isEmpty) {
                          return 'Please enter a number';
                        }
                        final number = double.tryParse(value);
                        if (number == null) {
                          return 'Invalid number';
                        }
                        return null;
                      },
                      textInputType: TextInputType.number,
                      hintText: "Level",
                      labelText: 'Level',
                      labelStyle: Styles.font14w500,
                      controller: bloc.levelController,
                    ),
                    CustomAppButton(
                      margin: EdgeInsets.only(top: 20.h),
                      loading: state is ProfileLoadingState,
                      onTap: () {
                        if (!bloc.academicFormKey.currentState!.validate()) return;
                        bloc.add(UpdateMyAcademicDataEvent());
                      },
                      label: "Save Changes",
                      textStyle: Styles.font16w700
                          .copyWith(color: ColorsManager.whiteColor),
                      width: 260.w,
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
