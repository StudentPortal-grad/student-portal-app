import 'package:flutter/material.dart';

import '../../../../core/theming/colors.dart';

class ResourceDetailsScreen extends StatelessWidget {
  const ResourceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
