// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Utilities/routes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String name = "";
  bool pressed = false;
  final _formkey = GlobalKey<FormState>();

  moveHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        pressed = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, Routes.HomePath);
      setState(() {
        pressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
            child: Form(
      key: _formkey,
      child: Column(children: [
        SizedBox(
          height: 50,
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
              TextFormField(
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
                  onTap: () => moveHome(context),
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: pressed ? 50 : 150,
                    height: 40,
                    alignment: Alignment.center,
                    child: pressed
                        ? Icon(color: Colors.black, Icons.done)
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
