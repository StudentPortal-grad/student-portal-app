import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_image_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startLoadingAnimation();
  }

  void startLoadingAnimation() async {
    _timer = Timer(const Duration(seconds: 2), navigateToHome);
  }

  void navigateToHome() async {
    final model = await getIt<SecureStorage>().readSecureData();
    // final isFirst = await getIt<SecureStorage>().readOnboardingData();

    final route = (model?.id == null || model?.accessToken == null)
        ? (AppRouter.loginView) // isFirst ? AppRouter.onBoardingView : login
        : AppRouter.homeView;

    AppRouter.router.pushReplacement(route);
  }

  @override
  void dispose() {
    _timer?.cancel(); // Ensure the timer is canceled to avoid memory leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: AssetsApp.logo,
              height: 50.r,
              width: 50.r,
              color: Colors.white,
            ),
            10.widthBox,
            Text(
              "Student Portal",
              style: Styles.font22w700
                  .copyWith(color: Colors.white, fontSize: 28.sp),
            ),
          ],
        ),
      ),
    );
  }
}
