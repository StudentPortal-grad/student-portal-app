import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../../../core/widgets/custom_image_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int loadingProgress = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startLoadingAnimation();
  }

  void startLoadingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 900), (timer) {
      if (loadingProgress < 3) {
        setState(() => loadingProgress++);
      } else {
        timer.cancel();
        navigateToHome();
      }
    });
  }

  void navigateToHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final model = await SecureStorage().readSecureData();
      final isFirst = await SecureStorage().readOnboardingData();
      log(model?.toJson().toString() ?? "NULL");
      if (model?.id == null || model?.accessToken == null) {
        AppRouter.router.pushReplacement(
          isFirst ? AppRouter.onBoardingView : AppRouter.loginView,
        );
      } else {
        AppRouter.router.pushReplacement(AppRouter.homeView);
      }
    });
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
              style: Styles.font22w700.copyWith(color: Colors.white, fontSize: 28.sp),
            ),
          ],
        ),
      ),
    );
  }
}
