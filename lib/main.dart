// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ireo/Authentication/register.dart';
import 'package:ireo/Pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ireo/Pages/wordle.dart';
import 'package:ireo/Tasks/listtasks.dart';

import 'Pages/home.dart';
import 'Pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Login(),
        "/home": (context) => Home(),
        "/wordle": (context) => GameScreen(),
        "/register": (context) => Register(),
        "/tasks": (context) => TasksList(),
      },
    );
  }
}
