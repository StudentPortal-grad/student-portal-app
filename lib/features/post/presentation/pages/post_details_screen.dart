import 'package:flutter/material.dart';
import 'package:student_portal/core/theming/colors.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});

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
