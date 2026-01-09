import 'package:hive/hive.dart';
import 'package:todo_db/db/dbInterface/db_interface.dart';
import 'package:todo_db/model/todo.dart';

Box? hiveBox;
List<Todo> todoList = [];

class DbFunctions implements DbInterface {
  @override
  Future<void> add(Todo todo) async {
    int key = await hiveBox!.add(todo);
    todo.id = key;
    await getAll();
  }

  @override
  Future<void> delete(int? id) async {
    await hiveBox!.delete(id);

    await getAll();
  }

  @override
  void deleteAll() {
    // TODO: implement deleteAll
  }

  @override
  Future<void> edit(Todo todo) async {
    await hiveBox!.put(todo.id, todo);
    await getAll();
  }

  @override
  Future<void> getAll() async {
    final data = hiveBox!.values.toList();
    todoList.clear();
    todoList.addAll(data as Iterable<Todo>);
  }
}
