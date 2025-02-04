import 'dart:ui';
import 'package:flutter/material.dart';

class BlurWidget extends StatelessWidget {
  final double? blurStrength;
  final Widget child;

  const BlurWidget({
    super.key,
    this.blurStrength,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (blurStrength == null) return child;
    return Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurStrength!,
                sigmaY: blurStrength!,
              ),
              child: Container(
                color: Colors.grey.withValues(alpha: 0.02),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
