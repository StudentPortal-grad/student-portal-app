import 'package:flutter/material.dart';

import '../utils/assets_app.dart';

class NetworkErrorImageVeiw extends StatelessWidget {
  const NetworkErrorImageVeiw({
    super.key,
    this.width,
    this.hight,
    this.backgroundColor = const Color(0xff585858),
    this.radius = 20,
  });

  final double? width, hight, radius;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Center(
      child: Container(
        width: width ?? size.width,
        height: hight ?? 200,
        decoration: BoxDecoration(
          color: const Color(0xff585858),
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: Image.asset(
          AssetsApp.logo,
          color: const Color(0xffb8b8b8),
          fit: BoxFit.none,
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}
