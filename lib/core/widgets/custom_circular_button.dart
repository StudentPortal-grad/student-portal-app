import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularPercentIndicator extends StatelessWidget {
  const CustomCircularPercentIndicator({
    super.key,
    required this.child,
    this.radius = 25,
    required this.percent,
  });

  final Widget child;
  final double radius, percent;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      progressColor: const Color(0xff86c13d),
      radius: radius,
      lineWidth: 2.6,
      animation: true,
      percent: percent,
      backgroundColor: Colors.black,
      center: child,
    );
  }
}
