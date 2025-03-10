import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/helpers/custom_toast.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/widgets/custom_app_button.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';
import 'package:student_portal/features/profile/presentation/manager/profile_bloc/profile_bloc.dart';

import '../../../../contestants.dart';
import '../../../../core/theming/text_styles.dart';

class ProfileDataScreen extends StatelessWidget {
  const ProfileDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColorLight,
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.backgroundColorLight,
        title: 'Profile Data'.make(style: Styles.font20w600),
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc(),
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccessState) {
              CustomToast(context)
                  .showSuccessToast(message: "Profile Updated Successfully");
              AppRouter.router.pop();
            }
            if (state is ProfileFailureState) {
              CustomToast(context).showErrorToast(
                  message: state.failure.message ??
                      "Unknown Error, Please try again later");
            }
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<ProfileBloc>(context);
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: bloc.profileFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.heightBox,
                    // profile image
                    InkWell(
                      onTap: () => bloc.add(OnProfileImagePicked()),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CustomImageView(
                            width: 100.w,
                            height: 100.h,
                            circle: true,
                            placeHolder: kUserPlaceHolder,
                            imagePath: bloc.profileImage ??
                                UserRepository.user?.profilePicture,
                          ),
                          CircleAvatar(
                            radius: 15.r,
                            backgroundColor: ColorsManager.mainColor,
                            child: Icon(
                              Icons.edit,
                              size: 16.r,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    // personal Data
                    CustomTextField(
                      labelText: 'Display Name',
                      hintText: 'Display Name',
                      labelStyle: Styles.font14w500,
                      controller: bloc.nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    20.heightBox,
                    CustomTextField(
                      labelText: 'Username',
                      hintText: 'Username',
                      labelStyle: Styles.font14w500,
                      inputFormatters: [
                        // Prevent spaces
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your user name';
                        }
                        return null;
                      },
                      prefixIcon:
                          Center(child: Text('@', style: Styles.font14w500)),
                      controller: bloc.userNameController,
                    ),
                    20.heightBox,
                    CustomTextField(
                      labelText: 'Bio',
                      hintText: 'Bio',
                      labelStyle: Styles.font14w500,
                      controller: bloc.bioController,
                    ),
                    30.heightBox,
                    CustomAppButton(
                      loading: state is ProfileLoadingState,
                      onTap: () {
                        if (!bloc.profileFormKey.currentState!.validate()) return;
                        bloc.add(UpdateMyProfileDataEvent());
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
