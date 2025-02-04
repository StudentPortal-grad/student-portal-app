import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../contestants.dart';
import '../utils/app_router.dart';

/// A customizable toast utility class.
class CustomToast {
  final BuildContext? context;
  late final FToast _fToast;

  /// Initializes the [CustomToast] with a [BuildContext].
  CustomToast([this.context]) {
    _fToast = FToast();
    if(context == null && AppRouter.context == null) return;
    _fToast.init(context ?? AppRouter.context!);
  }

  /// A private method to display a toast with a [CustomToastBody].
  void _showToast({
    required CustomToastBody toastBody,
    int durationInMillis = 3000,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    _fToast.showToast(
      toastDuration: Duration(milliseconds: durationInMillis),
      gravity: gravity,
      child: toastBody.build(),
    );
  }

  /// Displays a general toast with the provided [CustomToastBody].
  void showToast({
    required CustomToastBody toastBody,
    int durationInMillis = 3000,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    _showToast(
      toastBody: toastBody,
      durationInMillis: durationInMillis,
      gravity: gravity,
    );
  }

  /// Displays an error toast.
  void showErrorToast({
    String? message,
    int durationInMillis = 3000,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    _showToast(
      toastBody: CustomToastBody(
        msg: message ?? "Unknown Error",
        icon: const Icon(Icons.error, color: Colors.red),
      ),
      durationInMillis: durationInMillis,
      gravity: gravity,
    );
  }

  /// Displays a success toast.
  void showSuccessToast({
    String? message,
    int durationInMillis = 3000,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    _showToast(
      toastBody: CustomToastBody(
        msg: message ?? "Success",
        icon: const Icon(Icons.check, color: kMainColor),
      ),
      durationInMillis: durationInMillis,
      gravity: gravity,
    );
  }

  // display a loading toast
  void showLoadingToast({
    int durationInMillis = 3000,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    _showToast(
      toastBody: const CustomToastBody(
        msg: "Loading...",
        icon: CircularProgressIndicator(
          color: kMainColor,
          strokeWidth: 1.5,
        ),
      ),
      durationInMillis: durationInMillis,
      gravity: gravity,
    );
  }
}

/// A customizable body for the toast UI.
class CustomToastBody {
  final Color backgroundColor;
  final Widget? icon;
  final String? msg;
  final TextStyle textStyle;
  final double borderRadius;

  const CustomToastBody({
    this.backgroundColor = Colors.black,
    this.icon,
    this.msg,
    this.textStyle = const TextStyle(
      color: Color(0xfff8faf0),
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
    this.borderRadius = 25,
  });

  /// Builds the toast UI widget.
  Widget build() {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 15.w),
            ],
            Flexible(
              child: Text(
                msg ?? "",
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
