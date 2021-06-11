import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => user;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) _user = null;
    if (googleUser != null) {
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final usrData =
          await FirebaseAuth.instance.signInWithCredential(credentials);
      print("User Data : $usrData");
    }
  }

  notifyListeners();
}
