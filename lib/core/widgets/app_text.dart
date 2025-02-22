import 'package:deep_text/deep_text.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
