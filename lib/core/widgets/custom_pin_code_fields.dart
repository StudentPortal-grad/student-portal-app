import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../theming/colors.dart';

class CustomVerificationCode extends StatelessWidget {
  const CustomVerificationCode({
    super.key,
    this.onChange,
    this.onCompleted,
    this.backgroundColor = const Color(0xffFAFAFC),
     this.codeController,
  });

  final TextEditingController? codeController;
  final Function(String value)? onCompleted, onChange;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      keyboardType: TextInputType.number,
      showCursor: false,
      obscureText: false,
      length: 6,
      autoDisposeControllers: true,
      animationType: AnimationType.fade,
      textStyle: TextStyle(fontSize: 30.sp, color: Colors.black),
      pinTheme: PinTheme(
        selectedFillColor: Colors.transparent,
        selectedColor: ColorsManager.mainColor,
        shape: PinCodeFieldShape.box,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 4.w),
        borderRadius: BorderRadius.all(Radius.circular(16.sp)),
        fieldHeight: 45.w,
        fieldWidth: 45.h,
        errorBorderColor: Colors.red,
        inactiveColor: ColorsManager.mainColor,
        inactiveFillColor: backgroundColor,
        activeFillColor: Colors.transparent,
        activeColor: Colors.transparent,
      ),
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.bounceInOut,
      enableActiveFill: true,
      controller: codeController,
      onChanged: (value) => (onChange != null) ? onChange!(value) : () {},
      onCompleted: (value) =>
          (onCompleted != null) ? onCompleted!(value) : () {},
    );
  }
}
