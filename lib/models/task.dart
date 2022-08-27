class Task {
  final int id;
  final String task;
  final DateTime dateTime;

  const Task({required this.id, required this.task, required this.dateTime});

  Map<String, dynamic> list() {
    return ({'id': id, 'created': dateTime.toString(), 'task': task});
  }
}
