import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';

import '../../widgets/custom_app_button.dart';
import '../../widgets/custom_appbar.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    this.failure,
    this.onRetry,
    this.dismissible,
    this.onDismiss,
  });

  final Failure? failure;
  final Function()? onRetry, onDismiss;
  final bool? dismissible;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: dismissible ?? false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          onDismiss?.call();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent
        ),
        backgroundColor: ColorsManager.backgroundColorLight,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: AssetsApp.errorImage,
                  width: 280.w,
                  height: 200.h,
                ),
                30.heightBox,
                Text(
                  failure?.message ?? 'Ops! Something went wrong!',
                  textAlign: TextAlign.center,
                  style: Styles.font22w700.copyWith(color: Colors.black),
                ),
                10.heightBox,
                Text(
                  failure?.details ??
                      "The connection to server is failed,\nPlease Try Again Later.",
                  textAlign: TextAlign.center,
                  style: Styles.font16w500.copyWith(color: Colors.black),
                ),
                40.heightBox,
                if (onRetry != null)
                  CustomAppButton(
                    label: "Retry",
                    onTap: () => onRetry?.call(),
                    width: 180.w,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
