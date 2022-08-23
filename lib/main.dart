// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ireo/Authentication/email_auth.dart';
import 'package:ireo/Authentication/g_auth.dart';
import 'package:ireo/Authentication/sign_in.dart';
import 'package:ireo/Pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ireo/Pages/wrapper.dart';
import 'package:provider/provider.dart';

import 'Pages/home.dart';
import 'Pages/login.dart';
import 'Utilities/routes.dart';
import 'Pages/wordle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: ((context) =>
                context.read<AuthenticationService>().authStateChanges),
            initialData: null,
          ),
        ],
        child: MaterialApp(
            themeMode: ThemeMode.light,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: GoogleFonts.nunito().fontFamily,
            ),
            home: AuthWrapper(index: -1),
            // initialRoute: "/",
            routes: {
              // "/": (context) => Wrapper(),
              // "/": (context) => SignIn(),
              // "/": (context) => AuthWrapper(),
              Routes.WordlePath: (context) => GameScreen(),
              Routes.HomePath: (context) => Home(),
              Routes.LoginPath: (context) => SignIn(),
              // Routes.RegisterPath:(context) => Register()
            }));
  }
}

class AuthWrapper extends StatelessWidget {
  final int index;
  const AuthWrapper({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<AuthenticationService>().signOut();
    final firebaseuser = context.read<AuthenticationService>().currentUser;
    if (index == 1) {
      return Home();
    } //else if (index == 2) {
    //return Register();}
    else if (index == 0) {
      return SignIn();
    }

    if (firebaseuser != null) {
      return AuthWrapper(index: 1);
      // return Home();
    } else {
      return AuthWrapper(index: 0);
    }
    // return Login();
  }
}
  // @override
  // Widget build(BuildContext context) => ChangeNotifierProvider(
  //     create: (context) => GAuthService(),
  //     child: MaterialApp(
  //         themeMode: ThemeMode.light,
  //         theme: ThemeData(
  //           primarySwatch: Colors.blue,
  //           fontFamily: GoogleFonts.nunito().fontFamily,
  //         ),
  //         initialRoute: "/",
  //         routes: {
  //           // "/": (context) => Wrapper(),
  //           "/": (context) => SignIn(),
  //           Routes.WordlePath: (context) => GameScreen(),
  //           Routes.HomePath: (context) => Home(),
  //           Routes.LoginPath: (context) => Login()
  //         }));