// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color colour;
  final Color backgroundColour;

  final VoidCallback onClicked;

  const Button(
      {Key? key,
      required this.text,
      required this.onClicked,
      this.colour = Colors.white,
      this.backgroundColour = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            primary: backgroundColour),
        onPressed: onClicked,
        child: Text(
          text,
          style: TextStyle(fontSize: 15, color: colour),
        ),
      ),
    );
  }
}
