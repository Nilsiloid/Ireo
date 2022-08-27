// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

    documentReference
        .set(taskList)
        .whenComplete(() => debugPrint("Data store zale huhuhu"));
  }

  deleteTask(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTasks").doc(item);

    documentReference.delete().whenComplete(() => print("Done!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("MyTasks").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("POOOOOOOOOOOO");
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text((documentSnapshot != null)
                              ? (documentSnapshot["taskName"])
                              : ""),
                          subtitle: Text((documentSnapshot != null)
                              ? ((documentSnapshot["task"] != null)
                                  ? documentSnapshot["task"]
                                  : "")
                              : ""),
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
          return Text("MESIII");
        },
      ),
    );
  }
}
