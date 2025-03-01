import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../widgets/invitation_item_view.dart';
import '../widgets/notification_item_view.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Notifications'.make(style: Styles.font20w600),
          backgroundColor: ColorsManager.backgroundColor),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.heightBox,
            "TODAY".make(
                style: Styles.font13w400.copyWith(color: ColorsManager.mainColor)),
            20.heightBox,
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => (index == 0) ? InvitationItemView() : NotificationItemView(),
                separatorBuilder: (context, index) => 10.heightBox,
                itemCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
