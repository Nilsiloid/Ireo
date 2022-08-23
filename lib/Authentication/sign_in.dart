// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, import_of_legacy_library_into_null_safe, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ireo/Authentication/email_auth.dart';
import 'package:ireo/Authentication/g_auth.dart';
import 'package:provider/provider.dart';
import '../Utilities/routes.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String name = "";
  bool pressedLog = false, pressedReg = false;
  final _formkey = GlobalKey<FormState>();

  moveHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        pressedLog = true;
      });
      await Future.delayed(Duration(seconds: 1));
      // await Navigator.pushNamed(context, Routes.HomePath);
      setState(() {
        pressedLog = false;
      });
    }
  }

  moveReg(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        pressedReg = true;
      });
      await Future.delayed(Duration(seconds: 1));
      // await Navigator.pushNamed(context, Routes.HomePath);
      setState(() {
        pressedReg = false;
      });
    }
  }
  // final GAuthService _authService = GAuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
            child: Form(
      key: _formkey,
      child: Column(children: [
        SizedBox(
          height: 100,
        ),
        Text(
          "Hello!",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Welcome to Ireo!",
          style: TextStyle(fontSize: 25),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          child: Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter Username",
                  labelText: "Username",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Invalid Username";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Invalid Password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40,
              ),
              Material(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: () {
                    moveHome(context);
                    context.read<AuthenticationService>().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: pressedLog ? 50 : 150,
                    height: 40,
                    alignment: Alignment.center,
                    child: pressedLog
                        ? Icon(color: Colors.black, Icons.android_sharp)
                        : Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Material(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: () {
                    moveReg(context);
                    context.read<AuthenticationService>().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: pressedReg ? 50 : 150,
                    height: 40,
                    alignment: Alignment.center,
                    child: pressedReg
                        ? Icon(color: Colors.black, Icons.done)
                        : Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   child: Text("Login"),
              //   style: TextButton.styleFrom(minimumSize: Size(150, 40)),
              //   onPressed: () {
              //     Navigator.pushNamed(context, Routes.HomePath);
              //   },
              // ),
            ],
          ),
        ),
      ]),
    )));
  }
}

    // return Scaffold(
    //   backgroundColor: Colors.blue[400],
    //   appBar: AppBar(
    //     backgroundColor: Colors.blue[600],
    //     elevation: 0.0,
    //     title: Text("Sign in to Ireo!"),
    //   ),
    //   body: Container(
    //     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
    //     child: TextFormField(controller: emailController,
    //     decoration: InputDecoration(alignLabelWithHint: ),)
    //     child: ElevatedButton(
    //         child: Text("Sign in using Google"),
    //         // onPressed: () async {
    //         //   dynamic result = await _authService.googleLogIn();
    //         //   if (result == null) {
    //         //     print("error signing in.");
    //         //   } else {
    //         //     print("Signed in!");
    //         //     print(result);
    //         //   }
    //         // },
    //         onPressed: () {
    //           // final provider =
    //           //     Provider.of<GAuthService>(context, listen: false);
    //           // provider.googleLogIn();
    //           context.read < AuthenticationService>().signIn(
    //             email: emailController.text.trim(),
    //           );
    //         }),
    //   ),
    // );
