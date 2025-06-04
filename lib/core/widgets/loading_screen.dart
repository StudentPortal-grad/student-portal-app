import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';

import '../utils/assets_app.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen(
      {super.key,
      this.baseColor,
      this.highlightColor,
      this.showAppBar = false});

  final Color? baseColor, highlightColor;

  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    if (showAppBar) {
      return Scaffold(
          appBar: CustomAppBar(
            backgroundColor: Colors.transparent,
          ),
          body: _buildBodyView());
    }
    return _buildBodyView();
  }

  Widget _buildBodyView() {
    return Center(
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey[800]!,
        highlightColor: highlightColor ?? Colors.grey[700]!,
        child: CustomImageView(
          imagePath: AssetsApp.logo,
          height: 50.r,
          width: 50.r,
        ),
      ),
    );
  }
}
