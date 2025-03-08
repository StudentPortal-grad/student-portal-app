import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/user_row_view.dart';
import 'package:student_portal/features/settings/presentation/screens/personal_data_screen.dart';
import 'package:student_portal/features/settings/presentation/screens/profile_data_screen.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_app_button.dart';
import 'academic_data.dart';
import 'change_password_screen.dart';
import 'notification_settings_screen.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBabyBlue,
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.lightBabyBlue,
        centerTitle: false,
        title: Text(
          'Account Settings',
          style: Styles.font18w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        child: Column(
          children: [
            5.heightBox,
            UserRowView(),
            30.heightBox,
            // profile
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 18.h,
                children: [
                  "Account".make(style: Styles.font10w600),
                  _buildSettingsItem(
                      title: "Profile Data",
                      icon: Icons.person,
                      onTap: () {
                        push(ProfileDataScreen());
                      }),
                  _buildSettingsItem(
                      title: "Personal Data",
                      icon: Icons.person,
                      onTap: () {
                        push(PersonalDataScreen());
                      }),
                  _buildSettingsItem(
                      title: "Academic Data",
                      icon: Icons.person,
                      onTap: () {
                        push(AcademicDataScreen());
                      }),
                  _buildSettingsItem(
                    title: "Change Password",
                    icon: Icons.settings,
                    onTap: () {
                      push(ChangePasswordScreen());
                    },
                  ),
                ],
              ),
            ),
            20.heightBox,
            // Preference
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 18.h,
                children: [
                  "Preference".make(style: Styles.font10w600),
                  _buildSettingsItem(
                    title: "Notification",
                    icon: Icons.notifications_rounded,
                    onTap: () {
                      push(NotificationSettingsScreen());
                    },
                  ),
                ],
              ),
            ),
            20.heightBox,
            // Help
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 18.h,
                children: [
                  "Help".make(style: Styles.font10w600),
                  _buildSettingsItem(
                      title: "Support and Feedback",
                      icon: Icons.contact_support_outlined),
                  _buildSettingsItem(
                      title: "Privacy Center", icon: Icons.shield),
                ],
              ),
            ),
            30.heightBox,
            CustomAppButton(
              width: 0.8.sw,
              label: "Sign Out",
              onTap: () {
                // call logout endpoint
                AppRouter.clearAndNavigate(AppRouter.loginView);
              },
              backgroundColor: Colors.white,
              textStyle:
                  Styles.font15w600.copyWith(color: ColorsManager.orangeColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required IconData icon,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: ColorsManager.lightGrayColor),
          12.widthBox,
          Text(title, style: Styles.font15w600),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded,
              color: ColorsManager.lightGrayColor, size: 15.r),
        ],
      ),
    );
  }
}
