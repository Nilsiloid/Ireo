// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_element, unused_import

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ireo/Authentication/email_auth.dart';
import 'package:ireo/Pomodoro/pomodoro_main.dart';
import 'package:ireo/Utilities/routes.dart';
import 'package:ireo/main.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _tasks(
      {required Color color, required String title, required String subtitle}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.only(left: 20),
      height: 80,
      width: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(title,
                style: TextStyle(color: Colors.white, fontSize: 17.0)),
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(subtitle, style: TextStyle(color: Colors.white, fontSize: 12.0)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthWrapper(index: 0)));
              },
              child: Text("Sign Out"))
        ],
      )),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "IIIT-B",
          style: TextStyle(fontSize: 15.0),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 30),
                      child: Text(
                        "Tasks",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30, left: 30),
                        child: Row(children: [
                          _tasks(
                              color: Theme.of(context).colorScheme.secondary,
                              title: "Important",
                              subtitle: "Maths Assignment"),
                          _tasks(
                              color: Theme.of(context).colorScheme.secondary,
                              title: "Urgent",
                              subtitle: "Physics Assignment"),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, Routes.PomodoroPath);
                    },
                    child: Text(
                      "Pomodoro Study",
                      style: TextStyle(fontSize: 15),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
