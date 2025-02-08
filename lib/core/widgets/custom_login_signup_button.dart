import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../utils/app_router.dart';

class CustomLoginSignupButton extends StatelessWidget {
  const CustomLoginSignupButton({super.key, required this.isLogin});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          (isLogin) ? "Don’t Have an account? " : "Already have account? ",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Color(0xff7D8A95),
            fontSize: 14.sp,
          ),
        ),
        InkWell(
          onTap: () => AppRouter.router.pushReplacement(
            (isLogin) ? AppRouter.signupView : AppRouter.loginView,
          ),
          child: Text(
            (isLogin) ? "Signup" : "Login",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: ColorsManager.mainColor,
              decoration: TextDecoration.underline,
              decorationColor: ColorsManager.mainColor,
            ),
          ),
        )
      ],
    );
  }
}
