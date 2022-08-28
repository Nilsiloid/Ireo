// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, non_constant_identifier_names, use_build_context_synchronously, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ireo/Utilities/routes.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  String user_email = "";
  String user_name = "";

  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  bool validpass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF73AEF5),
            Color(0xFF61A4F1),
            Color(0XFF478DE0),
            Color(0XFF398AE5)
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        )),
      ),
      Container(
          padding: EdgeInsets.only(top: 40, left: 20),
          alignment: AlignmentDirectional.topStart,
          child: Row(
            children: [
              // IconButton has error, to be fixed.
              IconButton(
                  icon: Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.LoginPath);
                  }),
              Text(
                "Ireo",
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ],
          )),
      Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                    ),
                    TextFormField(
                      controller: userName,
                      decoration: InputDecoration(
                        hintText: "Enter Username",
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Email ID",
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: userEmail,
                      decoration: InputDecoration(
                        hintText: "Enter Email-ID",
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Password",
                    ),
                    TextFormField(
                      controller: userPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password(>6 letters)",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    (userPassword.text.length <= 6)
                        ? validpass = true
                        : validpass = false;

                    final user = <String, dynamic>{
                      "username": userName.text,
                      "email": userEmail.text,
                    };

                    await signUp(userEmail.text, userPassword.text);
                    db.collection("users").doc(userEmail.text).set(user);
                    user_email = userEmail.text;
                    final DocumentReference documentReference =
                        db.collection("users").doc(user_email);

                    documentReference
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      final data =
                          documentSnapshot.data() as Map<String, dynamic>;
                      user_name = data['username'];
                    });

                    Navigator.pushNamed(context, Routes.HomePath);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 40),
                    padding: EdgeInsets.all(10),
                    primary: Colors.blue[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              SizedBox(
                height: 50.0,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.LoginPath);
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }

  Future<void> signUp(String? em, String? pwd) async {
    await auth
        .createUserWithEmailAndPassword(email: em!, password: pwd!)
        .then((uid) => "Signed In!")
        .catchError((e) => debugPrint(e));
  }
}
