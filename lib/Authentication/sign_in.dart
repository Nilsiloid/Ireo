// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ireo/Authentication/g_auth.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // final GAuthService _authService = GAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0.0,
        title: Text("Sign in to Ireo!"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
            child: Text("Sign in using Google"),
            // onPressed: () async {
            //   dynamic result = await _authService.googleLogIn();
            //   if (result == null) {
            //     print("error signing in.");
            //   } else {
            //     print("Signed in!");
            //     print(result);
            //   }
            // },
            onPressed: () {
              final provider =
                  Provider.of<GAuthService>(context, listen: false);
              provider.googleLogIn();
            }),
      ),
    );
  }
}
