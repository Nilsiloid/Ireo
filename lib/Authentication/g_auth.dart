// ignore_for_file: unused_field, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GAuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final gSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  // Stream<User?> get person {
  //   return _auth.authStateChanges();
  // }

  Future<bool?> googleLogIn({bool newUser = false}) async {
    final guser = await gSignIn.signIn();

    _user = guser;

    final gauth = await guser.authentication;
    final creds = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(creds);
      notifyListeners();
    } on FirebaseException catch (e) {
      debugPrint(e.code);
    }

    return null;
    // notifyListeners();
  }
}
