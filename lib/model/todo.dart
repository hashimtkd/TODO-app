import 'package:intl/intl.dart';

class Todo {
  int? id;

  final String task;

  final DateTime date;

  Todo({required this.task, required this.date, this.id});

  factory Todo.fromMap(Map<dynamic, dynamic> map) => Todo(
    task: map['task'] as String,
    date: DateFormat('dd-MM-yyyy').parse(map['date'] as String),
    id: map['id'] as int?,
  );
}
