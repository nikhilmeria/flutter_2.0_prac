import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthProvider {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  //auth change user STREAM
  static Stream<String?> get user {
    String currentUsrId;
    return _auth.authStateChanges().map((ei) {
      if (ei != null) {
        currentUsrId = ei.uid;
        return currentUsrId;
      } else {
        return null;
      }
    });
  }

  //fn to register with email & password
  static Future<void> register(String? email, String? password) async {
    try {
      UserCredential createdUsr = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      print("user created => $createdUsr");
    } catch (e) {
      print("register error => ${e.toString()}");
      return null;
    }
  }

  //sign in with email & passowrd
  static Future<void> signIn(String? email, String? password) async {
    try {
      final resp = await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      print(" sign in done => ${resp.user}");
    } on PlatformException catch (e) {
      print(" sign in error => ${e.code}");
    }
  }

  //Fn to signOut
  static Future<void> signOutFn() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("signOut error => ${e.toString()}");
      return null;
    }
  }
}
