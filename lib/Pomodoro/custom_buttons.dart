// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 400,
      child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(fontSize: 15),
          )),
    );
  }
}
