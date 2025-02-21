import 'package:flutter/gestures.dart';
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
    return RichText(
      text: TextSpan(
        style: style ?? TextStyle(fontSize: 16, color: Colors.black),
        children: parseTextStyles(
          text,
          onHashTagTap: onHashTagTap,
          onMentionTap: onMentionTap,
        ),
      ),
    );
  }

  static List<TextSpan> parseTextStyles(String input,
      {Function(String)? onHashTagTap, Function(String)? onMentionTap}) {
    final RegExp regex = RegExp(
      r'(\*.*?\*)|(_.*?_)|(~.*?~)|(-.*?-)|(\#\w+)|(@\w+)|(`(?:.|\n)*?`)',
      multiLine: true,
    );

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (RegExpMatch match in regex.allMatches(input)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: input.substring(lastMatchEnd, match.start)));
      }

      String matchText = match[0]!;
      TextStyle style = TextStyle();
      GestureRecognizer? recognizer;

      if (matchText.startsWith('*') && matchText.endsWith('*')) {
        style = TextStyle(fontWeight: FontWeight.bold);
        matchText = matchText.substring(1, matchText.length - 1);
      } else if (matchText.startsWith('_') && matchText.endsWith('_')) {
        style = TextStyle(fontStyle: FontStyle.italic);
        matchText = matchText.substring(1, matchText.length - 1);
      } else if (matchText.startsWith('~') && matchText.endsWith('~')) {
        style = TextStyle(decoration: TextDecoration.underline);
        matchText = matchText.substring(1, matchText.length - 1);
      } else if (matchText.startsWith('-') && matchText.endsWith('-')) {
        style = TextStyle(decoration: TextDecoration.lineThrough);
        matchText = matchText.substring(1, matchText.length - 1);
      } else if (matchText.startsWith('`') && matchText.endsWith('`')) {
        style = TextStyle(
            fontFamily: 'monospace', backgroundColor: Colors.grey[200]);
        matchText = matchText.substring(1, matchText.length - 1);
      } else if (matchText.startsWith('#')) {
        style = TextStyle(color: ColorsManager.mainColorLight, fontWeight: FontWeight.bold);

        recognizer = TapGestureRecognizer()
          ..onTap = () => onHashTagTap?.call(matchText.substring(1));
      } else if (matchText.startsWith('@')) {
        style = TextStyle(
            color: ColorsManager.mainColor, fontWeight: FontWeight.bold);
        recognizer = TapGestureRecognizer()
          ..onTap = () => onMentionTap?.call(matchText.substring(1));
      }

      spans
          .add(TextSpan(text: matchText, style: style, recognizer: recognizer));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < input.length) {
      spans.add(TextSpan(text: input.substring(lastMatchEnd)));
    }

    return spans;
  }
}
