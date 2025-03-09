import 'package:flutter/material.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem(
      {super.key, this.title, required this.value, required this.onTap});

  final String? title;
  final bool value;
  final void Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          (title ?? "").make(style: Styles.font15w600),
          Spacer(),
          Switch(
            value: value,
            onChanged: onTap,
            activeColor: Colors.white,
            activeTrackColor: ColorsManager.mainColor,
            inactiveTrackColor: Color(0xffE6E6E6),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            thumbColor: WidgetStatePropertyAll(Colors.white),
            thumbIcon: WidgetStatePropertyAll(Icon(Icons.circle, size: 20, color: Colors.white)),
            trackOutlineWidth: WidgetStatePropertyAll(0),
          ),
        ],
      ),
    );
  }
}
