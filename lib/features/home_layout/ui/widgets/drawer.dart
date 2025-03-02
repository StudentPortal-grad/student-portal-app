import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/contestants.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_app_button.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';

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
          Row(
            children: [
              CustomImageView(
                imagePath: kUserImage,
                circle: true,
                height: 58.r,
                width: 58.r,
              ),
              12.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mina Zarif', style: Styles.font18w600),
                    4.heightBox,
                    Text(
                      '@mina10',
                      style: Styles.font12w400,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                      AppRouter.router.push(AppRouter.profile);
                    }),
                _buildDrawerItem(title: "Account Settings", icon: Icons.settings),
                _buildDrawerItem(title: "BookMark", icon: Icons.local_offer),
                _buildDrawerItem(title: "Your Communities", icon: Icons.people),
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
                Text('Help',style: Styles.font15w600.copyWith(fontSize: 10.sp,color: ColorsManager.mainColor)),
                _buildDrawerItem(title: "Support and Feedback", icon: Icons.contact_support_outlined),
                _buildDrawerItem(title: "Privacy Center", icon: Icons.shield),
              ],
            ),
          ),
          30.heightBox,
          CustomAppButton(
            label: "Sign Out",
            onTap: () {
              AppRouter.clearAndNavigate(AppRouter.loginView);
            },
            backgroundColor: Colors.white,
            textStyle: Styles.font15w600.copyWith(color: ColorsManager.orangeColor),
          ),
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
          Icon(icon, color: ColorsManager.lightGreyColor),
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
