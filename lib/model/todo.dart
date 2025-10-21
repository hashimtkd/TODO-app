import 'package:hive_flutter/adapters.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String task;
  @HiveField(2)
  final DateTime date;

  Todo({required this.task, required this.date, this.id});
}
