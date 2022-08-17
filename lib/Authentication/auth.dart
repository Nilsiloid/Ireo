// updated auth.dart to g_auth.dart due to issue using older versions of firebase.



// ignore_for_file: avoid_print, import_of_legacy_library_into_null_safe

// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:ireo/models/user.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // creating user object based on firebase object
//   User? _user(FirebaseUser user) {
//     return User(uid: user.uid);
//   }

//   // sign in anon

//   Future signInAnonymously() async {
//     try {
//       AuthResult result = await _auth.signInAnonymously();
//       FirebaseUser user = result.user;
//       return _user(user);
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//   // sign in with email and pass
//   // register with email and pass
//   // sign out
// }
