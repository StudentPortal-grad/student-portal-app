import 'dart:developer';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../contestants.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../../auth/data/model/token_model/token_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    startLoadingAnimation();
  }

  void startLoadingAnimation() {
    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        if (loadingProgress == 3) {
          navigateToHome();
        } else {
          loadingProgress = (loadingProgress + 1) % 4;
          startLoadingAnimation();
        }
      });
    });
  }

  void navigateToHome() async {
    TokenModel? model = await SecureStorage().readSecureData();
    // bool isFirst = await SecureStorage().readOnboardingData();
    log(model?.toJson().toString() ?? "NULL");
    AppRouter.router.pushReplacement(AppRouter.onBoardingView);
    return;
    if (model?.id == null ||
        model?.refreshToken == null ||
        model?.accessToken == null) {
      AppRouter.router.pushReplacement(AppRouter.signupView);
      // AppRouter.router.pushReplacement((isFirst) ? AppRouter.onBoardingView : AppRouter.signupView);
    } else {
      AppRouter.router.pushReplacement(AppRouter.homeView);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          top: size.height * 0.48,
          bottom: 25,
        ),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                AssetsApp.logo,
                fit: BoxFit.cover,
                width: 125,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            DotsIndicator(
              dotsCount: 4,
              mainAxisSize: MainAxisSize.min,
              position: loadingProgress,
              decorator: const DotsDecorator(
                color: Color(0xffc9e1b9),
                activeColor: kMainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
