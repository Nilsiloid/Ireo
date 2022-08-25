// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: Column(
        children: [
          SizedBox(
            height: 100.0,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                "Pomodoro",
                style: TextStyle(fontSize: 25),
              )),
          SizedBox(
            height: 60.0,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                "Tasks",
                style: TextStyle(fontSize: 25),
              )),
          SizedBox(
            height: 60.0,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                "Alarm",
                style: TextStyle(fontSize: 25),
              )),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                "Sign Out",
                style: TextStyle(fontSize: 25),
              )),
        ],
      )),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text(
          "IIIT_B",
          style: TextStyle(fontSize: 15.0),
        ),
      ),
    );
  }
}
