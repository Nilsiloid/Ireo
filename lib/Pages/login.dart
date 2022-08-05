// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        SizedBox(
          height: 25,
        ),
        Text(
          "Hello!",
          style: TextStyle(
            fontSize: 25
          ),
        ),
      ]
    )
    );
  }
}
