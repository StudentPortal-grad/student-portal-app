import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_app_button.dart';

Future<void> showMyDialog({
  required BuildContext context,
  String title = 'Want this?',
  String subTitle =
      'Became a member account\nto unlock all the special\nFeatures!',
  String label = 'upgrade',
  bool showDecorationImage = true,
  Widget? suffixIcon,
  Function()? onTap,
  double? width,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: width ?? 180.w,
          decoration: BoxDecoration(
            color: const Color(0xff202122),
            image: (showDecorationImage)
                ? const DecorationImage(
                    image: AssetImage(AssetsApp.dialogDecoration),
                    fit: BoxFit.fill,
                  )
                : null,
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: const EdgeInsetsDirectional.only(
            start: 25,
            top: 15,
            end: 15,
            bottom: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () => AppRouter.router.pop(),
                  child: const Icon(
                    Icons.cancel_sharp,
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Sen',
                  fontWeight: FontWeight.w700,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                subTitle,
                style: const TextStyle(
                  color: Color(0xffc3c3c4),
                  fontSize: 18,
                  fontFamily: 'Sen',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.50,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 35),
              Center(
                child: CustomAppButton(
                  width: (width ?? 180.w) * 0.7,
                  suffixIcon: suffixIcon,
                  label: label,
                  onTap: () {
                    if (onTap != null) onTap();
                    AppRouter.router.pop();
                  },
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
