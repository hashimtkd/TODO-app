import 'package:todo_db/model/todo.dart';

abstract class DbInterface {
  Future<void> add(Todo todu);
  Future<void> getAll();
  void edit(Todo todu);
  Future<void> delete(int? id);
  void deleteAll();
}
