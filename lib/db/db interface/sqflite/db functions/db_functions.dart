import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_db/db/db%20interface/db_interface.dart';
import 'package:todo_db/model/todo.dart';

Database? database;
List<Todo> todoList = [];

class DbFunctions implements DbInterface {
  Future<void> initialize() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT,task TEXT NOT NULL,date TEXT NOT NULL)',
        );
      },
    );
  }

  @override
  Future<void> add(Todo todo) async {
    final key = await database!.rawInsert(
      'INSERT INTO todo(task,date) VALUES (?,?)',
      [todo.task, DateFormat('dd-MM-yyyy').format(todo.date)],
    );
    todo.id = key;
    await getAll();
  }

  @override
  Future<void> delete(int? id) async {
    await database!.rawDelete('DELETE FROM todo WHERE id=?', [id]);
    await getAll();
  }

  @override
  void deleteAll() {
    // TODO: implement deleteAll
  }

  @override
  Future<void> edit(Todo todo) async {
    await database!.rawUpdate('UPDATE todo SET task=?,date=? WHERE id=?', [
      todo.task,
      DateFormat('dd-MM-yyyy').format(todo.date),

      todo.id,
    ]);
    await getAll();
  }

  @override
  Future<void> getAll() async {
    todoList.clear();
    final list = await database!.rawQuery('SELECT * FROM todo');
    final _list = list.map((e) => Todo.fromMap(e)).toList();
    todoList.clear();
    todoList.addAll(_list);
    print(todoList);
  }
}
