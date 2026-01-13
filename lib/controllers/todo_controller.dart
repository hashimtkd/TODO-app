import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_db/components/date_picker.dart';
import 'package:todo_db/db/db%20functions/db_functions.dart';
import 'package:todo_db/model/todo.dart';

class TodoController extends GetxController {
  final db = DbFunctions();
  final taskControl = TextEditingController();
  final dateControl = TextEditingController();
  final timeControl = TextEditingController();

  RxList<Todo> todoList = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();

    getAll();
  }

  Future<void> add() async {
    if (taskControl.text.isNotEmpty && dateControl.text.isNotEmpty) {
      DateTime date0 = DateFormat('dd-MM-yyyy').parseStrict(dateControl.text);
      final todo = Todo(task: taskControl.text, date: date0);
      await db.add(todo);
      await getAll();
    }
  }

  Future<void> getAll() async {
    final list = await db.getAll();
    todoList.assignAll(list as Iterable<Todo>);
  }

  Future<void> delete(int? id) async {
    await db.delete(id);
    await getAll();
  }

  Future<void> edit(Todo todo) async {
    await db.edit(todo);
    await getAll();
  }

  Future<void> showDateController() async {
    dateControl.text = await showDate();
  }

  //Future<void> showTime() async {
  //await showTimePicker(context: Get.context!, initialTime: TimeOfDay.now());
  //}
}
