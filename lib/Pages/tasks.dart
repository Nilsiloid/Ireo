// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      appBar: AppBar(
        toolbarHeight: 45.0,
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text(
          "IIIT-B",
          style: TextStyle(fontSize: 22.0),
        ),
      ),
    );
  }
}
