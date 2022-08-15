// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // sign in anon

  Future signInAnonymously() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // sign in with email and pass
  // register with email and pass
  // sign out
}
