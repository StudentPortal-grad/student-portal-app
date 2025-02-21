// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:icure_doctor/ui/helper/app_size_boxes.dart';
// import 'package:student_portal/core/helpers/app_size_boxes.dart';
//
// import '../../../resources/app_decoration.dart';
// import '../../../widgets/app_shimmer.dart';
//
// class ChatLoading extends StatelessWidget {
//   const ChatLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: EdgeInsets.symmetric(vertical: 20.h),
//       reverse: true,
//       shrinkWrap: true,
//       itemBuilder: (c, i) => MessageLoading(),
//       separatorBuilder: (BuildContext context, int index) => 12.heightBox,
//       itemCount: 20,
//     );
//   }
// }
//
// class MessageLoading extends StatelessWidget {
//   const MessageLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Random random = Random();
//     int width = random.nextInt(300) + 100;
//     int height = random.nextInt(200) + 50;
//     width = max(width, height);
//     height = min(width, height);
//
//     final self = random.nextBool();
//     return AppShimmer(
//       child: Column(
//         crossAxisAlignment: self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: width.toDouble().w, height: height.toDouble().h,
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
//             decoration: self ? AppDecoration.myMessage.copyWith(color: Colors.black) : AppDecoration.otherMessage.copyWith(color: Colors.black),
//           ),
//           5.heightBox,
//           Container(
//             width: 35.w, height: 10.h,
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }
