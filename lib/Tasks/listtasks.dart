// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utilities/routes.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List tasks = List.empty();
  String title = "";
  String description = "";

  @override
  void initState() {
    super.initState();
  }

  createTask() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTasks").doc(title);

    Map<String, String> taskList = {"taskName": title, "task": description};

    documentReference.set(taskList);
  }

  deleteTask(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTasks").doc(item);

    documentReference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.HomePath);
          },
        ),
        backgroundColor: Colors.blue[400],
        leadingWidth: 30.0,
        title: Text(
          "Pending Work",
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xff1f005c),
                Color(0xff0072bb),
                Color(0xff7e9aab),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.5, 0.7],
            )),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("MyTasks").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData || snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      QueryDocumentSnapshot<Object?>? documentSnapshot =
                          snapshot.data?.docs[index];
                      return Dismissible(
                          key: Key(index.toString()),
                          child: Card(
                            color: Colors.green[100],
                            elevation: 4,
                            child: ListTile(
                              title: Text(
                                (documentSnapshot != null)
                                    ? (documentSnapshot["taskName"])
                                    : "",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                (documentSnapshot != null)
                                    ? ((documentSnapshot["task"] != null)
                                        ? documentSnapshot["task"]
                                        : "")
                                    : "",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.done),
                                color: Colors.green,
                                onPressed: () {
                                  setState(() {
                                    deleteTask((documentSnapshot != null)
                                        ? (documentSnapshot["taskName"])
                                        : "");
                                  });
                                },
                              ),
                            ),
                          ));
                    });
              }
              return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          setState(() {
            description = "";
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.blueGrey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  title: Text(
                    "Add Task",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  content: Container(
                      height: 100.0,
                      width: 400.0,
                      child: Column(children: [
                        TextFormField(
                          onChanged: (String value) {
                            title = value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Task Name(compulsory)",
                              hintStyle: TextStyle(fontSize: 15.0)),
                        ),
                        TextFormField(
                          onChanged: (String value) {
                            description = value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Task Description"),
                        ),
                      ])),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            createTask();
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
