/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Google
Future<Map<String, dynamic>?> signWithGoogle() async {
  await GoogleSignIn().signOut();
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  if (googleAuth == null) {
    // User canceled the sign-in process
    Fluttertoast.showToast(msg: 'Login With Google Canceled');
    return null;
  }

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final auth = await FirebaseAuth.instance.signInWithCredential(credential);

  print(auth.additionalUserInfo?.profile);
  if(auth.additionalUserInfo?.profile == null) {
    Fluttertoast.showToast(msg: 'Couldn\'t get auth info, please try again');
    return null;
  }

  return auth.additionalUserInfo!.profile;
}

// Facebook
Future<Map<String, dynamic>?> signWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  if (loginResult.accessToken == null) {
    // User canceled the sign-in process
    Fluttertoast.showToast(msg: 'Login With Facebook Canceled');
    return null;
  }
  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  final auth = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

  print(auth?.additionalUserInfo?.profile);
  if(auth?.additionalUserInfo?.profile == null) {
    Fluttertoast.showToast(msg: 'Couldn\'t get auth info, please try again');
    return null;
  }

  return auth!.additionalUserInfo!.profile;
}

// Apple
Future<Map<String, dynamic>?> signWithApple() async {
  final appleProvider = AppleAuthProvider();
  await FirebaseAuth.instance.signOut();
  final auth = await FirebaseAuth.instance.signInWithProvider(appleProvider);

  print(auth.additionalUserInfo?.profile);
  if(auth.additionalUserInfo?.profile == null) {
    Fluttertoast.showToast(msg: 'Couldn\'t get auth info, please try again');
    return null;
  }

  return auth.additionalUserInfo!.profile;
}*/
