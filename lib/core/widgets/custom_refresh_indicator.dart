import 'package:flutter/material.dart';
import 'package:student_portal/core/theming/colors.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? backgroundColor;
  final Color? color;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.backgroundColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      strokeWidth: 1.5,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: onRefresh,
      backgroundColor: backgroundColor ?? ColorsManager.whiteColor,
      color: color ?? ColorsManager.mainColor,
      child: child,
    );
  }
}
