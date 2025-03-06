// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:student_portal/core/theming/colors.dart';
//
// import '../../utils/assets_app.dart';
//
// class LoadingView extends StatefulWidget {
//   const LoadingView({super.key});
//
//   @override
//   State<LoadingView> createState() => _LoadingViewState();
// }
//
// class _LoadingViewState extends State<LoadingView> {
//   int loadingProgress = 0;
//   late bool _isDisposed; // Flag to check if the widget is disposed
//
//   @override
//   void initState() {
//     super.initState();
//     _isDisposed = false;
//     startLoadingAnimation();
//   }
//
//   @override
//   void dispose() {
//     _isDisposed = true; // Set flag to true when disposed
//     super.dispose();
//   }
//
//   void startLoadingAnimation() {
//     Future.delayed(const Duration(milliseconds: 900), () {
//       if (!_isDisposed) {
//         setState(() {
//           loadingProgress = (loadingProgress + 1) % 4;
//           startLoadingAnimation();
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsetsDirectional.only(
//         top: 50.h,
//         bottom: 25,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Image.asset(
//               AssetsApp.logo,
//               fit: BoxFit.cover,
//               width: 95,
//             ),
//           ),
//           SizedBox(height: 20.h),
//           DotsIndicator(
//             dotsCount: 4,
//             mainAxisSize: MainAxisSize.min,
//             position: loadingProgress,
//             decorator: const DotsDecorator(
//               color: Color(0xffc9e1b9),
//               activeColor: ColorsManager.mainColor,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
