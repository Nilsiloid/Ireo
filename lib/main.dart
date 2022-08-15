// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ireo/Pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ireo/Pages/wrapper.dart';

import 'Pages/home.dart';
import 'Pages/login.dart';
import 'Utilities/routes.dart';

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
        "/": (context) => Wrapper(),
        Routes.HomePath: (context) => Home(),
        Routes.LoginPath: (context) => Login()
      },
    );
  }
}
