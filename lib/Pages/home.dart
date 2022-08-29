// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_element, unused_import, sized_box_for_whitespace

// import 'package:flutter/cupertino.dart';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ireo/Authentication/email_auth.dart';
import 'package:ireo/Pomodoro/pomodoro_main.dart';
import 'package:ireo/Utilities/routes.dart';
import 'package:ireo/main.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Center(
            child: Text(
              "Sign Out",
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.LoginPath);
              },
              icon: Icon(
                Icons.logout_rounded,
                size: 25.0,
              ))
        ],
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "Welcome!",
          style: TextStyle(fontSize: 30.0),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue,
              Color(0xff0072bb),
              Color(0xff7e9aab),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5, 0.9],
          )),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 150.0,
              ),
              Container(
                height: 100.0,
                width: 350.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.TasksPath);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                  child: Center(
                    child: Text(
                      "Pending Tasks",
                      style: TextStyle(fontSize: 35.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              Container(
                height: 100.0,
                width: 350.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.PomodoroPath);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                  child: Center(
                    child: Text(
                      "Pomodoro",
                      style: TextStyle(fontSize: 35.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
