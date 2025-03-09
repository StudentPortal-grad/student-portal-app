import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../widgets/notification_item.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColorLight,
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.backgroundColorLight,
        title: 'Notifications'.make(style: Styles.font20w600),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 50.h),
        child: Column(
          children: [
            NotificationItem(
                value: true, onTap: (value) {}, title: 'General Notification'),
            _buildDivider(),
            NotificationItem(value: false, onTap: (value) {}, title: 'Sound'),
            _buildDivider(),
            NotificationItem(value: true, onTap: (value) {}, title: 'Vibration'),
            _buildDivider(),
            NotificationItem(value: false, onTap: (value) {}, title: 'Events'),
            _buildDivider(),
            NotificationItem(value: true, onTap: (value) {}, title: 'App Updates'),
            _buildDivider(),
            NotificationItem(value: true, onTap: (value) {}, title: 'Likes'),
            _buildDivider(),
            NotificationItem(value: true, onTap: (value) {}, title: 'Comments'),
            _buildDivider(),
            NotificationItem(value: true, onTap: (value) {}, title: 'Shares'),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => Divider(color: Color(0xffE6E6E6));
}
