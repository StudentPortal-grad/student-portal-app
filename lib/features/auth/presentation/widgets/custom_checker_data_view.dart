import 'package:flutter/material.dart';

class CustomCheckerDataView extends StatelessWidget {
  const CustomCheckerDataView({
    super.key,
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.1,
      height: 1.5,
      color: Color(0xffc5c5c5),
    ),
  });

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "• 8+ Characters",
              style: textStyle,
            ),
            const Spacer(),
            Text(
              "• 1 Uppercase Letter",
              style: textStyle,
            )
          ],
        ),
        Row(
          children: [
            Text(
              "• 1 Symbol",
              style: textStyle,
            ),
            const Spacer(),
            Text(
              "• 1 Lower Letter",
              style: textStyle,
            ),
          ],
        ),
        Text(
          "• 1 Number",
          style: textStyle,
        ),
      ],
    );
  }
}
