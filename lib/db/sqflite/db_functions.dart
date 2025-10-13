import 'package:sqflite/sqflite.dart';

import 'package:todo_db/db/db%20interface/db_interface.dart';
import 'package:todo_db/model/user.dart';

List<User> userList = [];
Database? database;

class DbFunctions implements DbInterface {
  DbFunctions() {
    getAll();
  }

  Future<void> initialize() async {
    database = await openDatabase(
      'userDb',
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age TEXT)',
        );
      },
    );
  }

  @override
  Future<void> add(User user) async {
    final key = await database!.rawInsert(
      'INSERT INTO user(name,age) VALUES(?,?)',
      [user.name, user.age],
    );
    user.id = key;
  }

  @override
  Future<void> delete(User user) async {
    await database!.rawDelete('DELETE FROM user WHERE id = ?', [user.id]);
    await getAll();
  }

  @override
  void deleteAll() {}

  @override
  Future<void> edit(User user) async {
    await database!.rawUpdate(
      'UPDATE user SET name = ? ,age = ? WHERE id = ?',
      [user.name, user.age, user.id],
    );
    await getAll();
  }

  @override
  Future<void> getAll() async {
    final list = await database!.rawQuery('SELECT * FROM user');
    userList.clear();
    userList = list.map((u) => User.fromMap(u)).toList();
    print(userList);
  }
}
