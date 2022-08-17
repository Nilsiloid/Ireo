// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ireo/Authentication/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Authenticate();
  }
}
