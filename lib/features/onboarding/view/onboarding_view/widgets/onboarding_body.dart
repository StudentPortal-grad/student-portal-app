import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/onboarding_model.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({
    super.key,
    required this.index,
    required this.model,
    required this.controller,
  });

  final int index;
  final OnboardingModel model;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsetsDirectional.only(top: size.height * 0.04),
      child: Column(
        children: [
        ],
      ),
    );
  }
}
