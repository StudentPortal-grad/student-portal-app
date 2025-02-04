import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../contestants.dart';

class AppDialogs {
  static void showErrorDialog(BuildContext context,
      {String error = 'there_was_an_error',
      String okText = 'try_again',
      bool dismissible = true,
      canPop = true,
      void Function()? onOkTap}) {
    AwesomeDialog(
      context: context,
      btnOkColor: kMainColor,
      animType: AnimType.bottomSlide,
      padding: EdgeInsets.zero,
      dialogBackgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Text(
          error,
        ),
      ),
      btnOkText: okText,
      btnOkOnPress: onOkTap ?? () => canPop ? Navigator.pop(context) : () {},
      buttonsTextStyle: const TextStyle(color: Colors.black),
      dialogType: DialogType.error,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      dismissOnBackKeyPress: dismissible,
      dismissOnTouchOutside: dismissible,
    ).show();
  }

  static Future<void> showDialog(
    BuildContext context, {
    String? okText,
    bool dismissible = true,
    EdgeInsets? outterPadding,
    EdgeInsets? innerPadding,
    AlignmentDirectional? alignment,
    void Function()? onOkTap,
    Widget? body,
  }) async {
    await AwesomeDialog(
      context: context,
      animType: AnimType.bottomSlide,
      padding: innerPadding ?? EdgeInsets.zero,
      bodyHeaderDistance: 0.0,
      body: body,
      btnOkText: okText,
      btnOkColor: kMainColor,
      btnOkOnPress: onOkTap,
      dialogType: DialogType.noHeader,
      dismissOnBackKeyPress: dismissible,
      dismissOnTouchOutside: dismissible,
      alignment: alignment ?? Alignment.center,
    ).show();
  }
}
