// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ireo/Authentication/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[400],
      appBar: AppBar(
        backgroundColor: Colors.brown[600],
        elevation: 0.0,
        title: Text("Sign in to Ireo!"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
          child: Text("Sign in Anonymously"),
          onPressed: () async {
            dynamic result = await _authService.signInAnonymously();
            if (result == null) {
              print("error signing in.");
            } else {
              print("Signed in!");
              print(result);
            }
          },
        ),
      ),
    );
  }
}
