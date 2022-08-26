import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class TaskProvider {
  TaskProvider._();
  static final TaskProvider taskProvider = TaskProvider._();

  static Database _dataBase;

  Future<Database> get taskProvider async {
    if (_database != null) {
      return _database;
    }

    _dataBase = await initDateBase();
    return _database;
  }

  initDataBase() async {
    return await openDatabase(join(await getDatabasesPath(), 'ireo_db.db'),
        onCreate: (db, version) async {
      await db.execute('''
CREATE TABLE tasks(id integer PRIMARY KEY AUTOINCREMENT, task TEXT , created TEXT''');
    }, version: 1);
  }

  addingNewTask(Task newTask) async {
    final db = await taskProvider;
    db.insert("tasks");
  }
}
