import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_portal/core/errors/data/model/error_model/error_model.dart';

import '../../widgets/custom_app_button.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.error, this.onRetry});

  final Failure error;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          error.message ?? 'Ops! Something went wrong!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontFamily: 'Sen',
            fontWeight: FontWeight.w700,
          ),
        ),
        // SizedBox(height: 15.h),
        SvgPicture.asset(
          "assets/images/connection_error_image.svg",
          height: 180.h,
        ),
        // SizedBox(height: 20.h),
        Text(
          "The connection to server is failed,\nPlease Try Again.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 19.sp,
            fontFamily: 'Sen',
            fontWeight: FontWeight.w400,
            height: 1.3.h,
          ),
        ),
        // SizedBox(height: 40.h),
        CustomAppButton(
          label: "Retry",
          onTap: onRetry ?? () {},
          width: 180.w,
        ),

      ],
    );
  }
}
