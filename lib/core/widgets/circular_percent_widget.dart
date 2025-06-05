import 'package:flutter/material.dart';
import 'package:student_portal/core/theming/colors.dart';

class CircularPercentWidget extends StatelessWidget {
  final double percent;

  const CircularPercentWidget({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    final clampedPercent = percent.clamp(0.0, 1.0);
    return SizedBox(
      height: 70,
      width: 70,
      child: CircularProgressIndicator(
        value: clampedPercent,
        strokeWidth: 3.5,
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.mainColor),
      ),
    );
  }
}
