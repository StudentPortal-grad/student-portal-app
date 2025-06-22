import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/utils/assets_app.dart';

import '../../../../../core/widgets/custom_image_view.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, this.height = 75});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
            ),
          ],
          borderRadius: BorderRadiusDirectional.vertical(
            bottom: Radius.circular(35.r),
          ),
        ),
        padding: EdgeInsetsDirectional.only(
          top: 10.h,
          start: 25.w,
          bottom: 20.h,
          end: 17.w,
        ),
        child: Row(
          children: [
            CustomImageView(
              onTap: () => Scaffold.of(context).openDrawer(),
              imagePath: UserRepository.user?.profilePicture,
              circle: true,
              height: 35.r,
              width: 35.r,
            ),
            Spacer(),
            _buildIconView(
              onTap: () {
                AppRouter.router.push(AppRouter.searchScreen);
              },
              iconPath: AssetsApp.searchIcon,
            ),
            _buildIconView(
                onTap: () {
                  AppRouter.router.push(AppRouter.notification);
                },
                iconPath: AssetsApp.notificationIcon,
                isNotification: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconView({
    Function()? onTap,
    required String iconPath,
    bool isNotification = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 30.r,
        backgroundColor: ColorsManager.lightBabyBlue,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            CustomImageView(
              imagePath: iconPath,
              circle: true,
              fit: BoxFit.none,
              height: 24.r,
              width: 24.r,
            ),
            if (isNotification)
              CircleAvatar(
                radius: 5.r,
                backgroundColor: ColorsManager.mainColor,
              )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
