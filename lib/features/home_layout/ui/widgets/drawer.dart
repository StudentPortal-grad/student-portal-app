import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import 'package:student_portal/core/widgets/user_row_view.dart';
import '../../../../core/repo/user_repository.dart';
import '../../../settings/presentation/widgets/logout_button.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsManager.lightBabyBlue,
      child: ListView(
        padding: EdgeInsets.only(
          right: 20.w,
          left: 20.w,
          top: 50.h,
        ),
        children: [
          _buildDrawerTitle(),
          30.heightBox,
          UserRowView(imageSize: 58.r,user: UserRepository.user),
          30.heightBox,
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            child: Column(
              spacing: 17.h,
              children: [
                _buildDrawerItem(
                    title: "Profile",
                    icon: Icons.person,
                    onTap: () {
                      AppRouter.router.push(
                        AppRouter.profile,
                        extra: {'userId': UserRepository.user?.id},
                      );
                    }),
                _buildDrawerItem(
                  title: "Settings",
                  icon: Icons.settings,
                  onTap: () => AppRouter.router.push(AppRouter.accountSettings),
                ),
                // _buildDrawerItem(title: "BookMark", icon: Icons.local_offer),
                // _buildDrawerItem(
                //     title: "Your Communities",
                //     icon: Icons.people,
                //     onTap: () {
                //       // temporarily navigate to community screen
                //       AppRouter.router.push(AppRouter.community);
                //     }),
              ],
            ),
          ),
          30.heightBox,
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 17.h,
              children: [
                Text('Help',
                    style: Styles.font15w600.copyWith(
                        fontSize: 10.sp, color: ColorsManager.mainColor)),
                _buildDrawerItem(
                    title: "Support and Feedback",
                    icon: Icons.contact_support_outlined),
                _buildDrawerItem(title: "Privacy Center", icon: Icons.shield),
              ],
            ),
          ),
          30.heightBox,
          LogoutButton()
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
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
        ],
      ),
    );
  }

  Widget _buildDrawerTitle() => Row(
        children: [
          CustomImageView(
            imagePath: AssetsApp.logo,
            height: 20.r,
            width: 20.r,
          ),
          10.widthBox,
          Text(
            "Student Portal",
            style: Styles.font16w700,
          ),
        ],
      );
}
