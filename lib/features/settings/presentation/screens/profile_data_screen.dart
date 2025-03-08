import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/widgets/custom_app_button.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';

import '../../../../contestants.dart';
import '../../../../core/helpers/file_service.dart';
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            20.heightBox,
            // profile image
            InkWell(
              onTap: () async {
                await FileService.pickImage();
              },
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CustomImageView(
                    width: 100.w,
                    height: 100.h,
                    circle: true,
                    placeHolder: kUserPlaceHolder,
                    imagePath: UserRepository.user?.profilePicture,
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
              controller:
                  TextEditingController(text: UserRepository.user?.name),
            ),
            20.heightBox,
            CustomTextField(
              labelText: 'Username',
              hintText: 'Username',
              inputFormatters: [
                // Prevent spaces
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
              prefixIcon: Center(child: Text('@', style: Styles.font14w500)),
              controller:
                  TextEditingController(text: UserRepository.user?.username),
            ),
            30.heightBox,
            CustomAppButton(
              onTap: () {},
              label: "Save Changes",
              textStyle:
                  Styles.font16w700.copyWith(color: ColorsManager.whiteColor),
              width: 260.w,
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
