import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/assets_app.dart';

class CustomSocialMediaButtons extends StatelessWidget {
  CustomSocialMediaButtons({super.key});

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignIn.signIn();
      debugPrint('User signed in: ${_googleSignIn.currentUser?.displayName}');
    } catch (error) {
      debugPrint(error.toString());
      debugPrint('Error signing in with Google. Try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconButton(AssetsApp.facebookIcon, () {}),
        _buildIconButton(AssetsApp.googleIcon, _handleGoogleSignIn),
        _buildIconButton(AssetsApp.xIcon, () {}),
      ],
    );
  }

  IconButton _buildIconButton(String iconPath, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(iconPath),
    );
  }
}
