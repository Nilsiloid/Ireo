// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, import_of_legacy_library_into_null_safe, use_build_context_synchronously, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ireo/main.dart';
import 'package:provider/provider.dart';
import '../Utilities/routes.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String userEmail = "";
  String userName = "";

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  // final _formkey = GlobalKey<FormState>();

  final TextEditingController emailID = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [
                Color(0xFF73AEF5),
                Color(0xFF61A4F1),
                Color(0XFF478DE0),
                Color(0XFF398AE5)
              ],
              // colors: [
              //   Colors.blueAccent,
              //   Colors.blue,
              //   Colors.yellow,
              //   Colors.yellowAccent,
              // ],
              stops: [0.1, 0.4, 0.7, 0.9],
              // stops: [0.3, 0.7, 0.8, 0.9],
            )),
          ),
          Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 1.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email ID",
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.blue[400],
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailID,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    hintText: "Enter Email-ID",
                                    // labelText: "Email-ID",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text("Password"),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.blue[400],
                                ),
                                child: TextFormField(
                                  controller: userPassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Enter Password",
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Container(
                              //   alignment: Alignment.centerRight,
                              //   child: TextButton(
                              //       onPressed: () {
                              //         debugPrint("Need to add code for this.");
                              //       },
                              //       child: Text(
                              //         "Forgot Password?",
                              //         style: TextStyle(color: Colors.black),
                              //       )),
                              // ),

                              // (Remember Me) function needs to be added.
                              // Container(
                              //   child: Row(
                              //     children: [
                              //       Theme(
                              //           data: ThemeData(
                              //               unselectedWidgetColor:
                              //                   Colors.white),
                              //           child: Checkbox(
                              //             onChanged: (value) {},
                              //             value: false,
                              //             checkColor: Colors.green,
                              //             activeColor: Colors.white,
                              //           ))
                              //     ],
                              //   ),
                              // ),
                            ],
                          )),
                      ElevatedButton(
                        onPressed: () async {
                          // if (emailID.text != null && userPassword.text != null) {
                          await signIn(emailID.text, userPassword.text);
                          userEmail = emailID.text;

                          final DocumentReference documentReference =
                              db.collection("users").doc(userEmail);

                          documentReference.get().then(
                            (DocumentSnapshot documentSnapshot) {
                              final data = documentSnapshot.data()
                                  as Map<String, dynamic>;
                              userName = data['username'];
                            },
                            onError: (e) {
                              debugPrint("Error: $e");
                            },
                          );
                          Navigator.pushNamed(context, Routes.HomePath);
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(200, 40),
                            padding: EdgeInsets.all(10),
                            primary: Colors.blue[300],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Do not have an account?",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.RegisterPath);
                                  },
                                  child: Text(
                                    "Sign Up!",
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ]),
                      )
                    ]),
              ))
        ],
      ),
    );
  }

  Future<void> signIn(String? ema, String? pass) async {
    await auth.signInWithEmailAndPassword(email: ema!, password: pass!);
  }
}
