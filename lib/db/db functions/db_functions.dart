import 'package:hive/hive.dart';
import 'package:todo_db/db/dbInterface/db_interface.dart';
import 'package:todo_db/model/todo.dart';

Box? hiveBox;

class DbFunctions implements DbInterface {
  @override
  Future<void> add(Todo todo) async {
    int key = await hiveBox!.add(todo);
    todo.id = key;
  }

  @override
  Future<void> delete(int? id) async {
    await hiveBox!.delete(id);
  }

  @override
  void deleteAll() {
    // TODO: implement deleteAll
  }

  @override
  Future<void> edit(Todo todo) async {
    await hiveBox!.put(todo.id, todo);
  }

  @override
  Future<List<dynamic>> getAll() async {
    final List<Todo> data = [];

    for (var key in hiveBox!.keys) {
      final Todo? todo = hiveBox!.get(key);
      if (todo != null) {
        todo.id = key;
        data.add(todo);
      }
    }

    return data;
  }
}
