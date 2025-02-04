import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/assets_app.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, this.baseColor, this.highlightColor});

  final Color? baseColor, highlightColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey[800]!,
        highlightColor: highlightColor ?? Colors.grey[700]!,
        child: Image.asset(
          AssetsApp.logo,
          height: 125,
        ),
      ),
    );
  }
}
