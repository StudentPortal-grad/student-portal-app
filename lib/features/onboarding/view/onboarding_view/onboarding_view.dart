import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/features/onboarding/view/onboarding_view/widgets/onboarding_body.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../../../core/widgets/custom_app_button.dart';
import 'data/data.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController controller;
  int index = 0;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    index = 0;
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mina: preferred to use screen utils instead of media query

    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xff1c1c1c),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.75,
            child: ExpandablePageView.builder(
              controller: controller,
              onPageChanged: (value) => setState(() => index = value),
              itemBuilder: (context, index) => OnboardingBody(
                index: index,
                model: onboardingModels[index],
                controller: controller,
              ),
              itemCount: 3,
            ),
          ),
          SizedBox(height: 20.h),
          DotsIndicator(
            dotsCount: 3,
            mainAxisSize: MainAxisSize.min,
            position: index,
            decorator: const DotsDecorator(
              activeColor: ColorsManager.mainColor,
              color: Color(0xffc9e1b9),
              activeSize: Size(10, 10),
              size: Size(8, 8),
            ),
          ),
          SizedBox(height: 20.h),
          CustomAppButton(
            label: (index == 2) ? "Start" : "Next",
            onTap: () async {
              if (index != 2) {
                controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              } else {
                await SecureStorage().writeOnboardingData(false);
                AppRouter.router.go(AppRouter.loginView);
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
