import 'package:flutter/material.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/features/home/presentation/view/widgets/app_bar_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      appBar: HomeAppBar(),
      body: Column(
        children: [
          SizedBox(height: 150),
          Text('data'),
        ],
      ),
    );
  }
}
