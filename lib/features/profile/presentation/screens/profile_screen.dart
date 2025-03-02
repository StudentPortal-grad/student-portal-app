import 'package:flutter/material.dart';
import 'package:student_portal/core/theming/colors.dart';import '../widgets/profile_card_veiw.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      body: Column(
        children: [
          ProfileCardView(),
        ],
      ),
    );
  }
}

