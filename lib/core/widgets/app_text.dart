import 'package:deep_text/deep_text.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/core/theming/colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final Function(String)? onHashTagTap;
  final Function(String)? onMentionTap;
  final TextStyle? style;

  const AppText({
    super.key,
    required this.text,
    this.onHashTagTap,
    this.style,
    this.onMentionTap,
  });

  @override
  Widget build(BuildContext context) {
    return DeepText(
      text: text,
      onHashTagTap: onHashTagTap,
      onMentionTap: onMentionTap,
      defaultStyle: style ??
          TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
      mentionStyle: const TextStyle(color: ColorsManager.mainColor),
      hashTagStyle: const TextStyle(color: ColorsManager.mainColorLight),
      enablePhones: false,
    );
  }
}
