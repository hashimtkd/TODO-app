// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_db/components/app_text.dart';
import 'package:todo_db/components/date_picker.dart';
import 'package:todo_db/controllers/todo_controller.dart';
import 'package:todo_db/model/todo.dart';

class EditPopup extends StatefulWidget {
  String task;
  DateTime date;
  int? id;

  EditPopup({super.key, required this.task, required this.date, this.id});

  @override
  State<EditPopup> createState() => _EditPopupState();
}

class _EditPopupState extends State<EditPopup> {
  late TextEditingController taskController;
  late TextEditingController dateController;

  final _formKey = GlobalKey<FormState>();
  TodoController controller = Get.find<TodoController>();

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController(text: widget.task);
    dateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(widget.date),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit your Task', style: TextStyle(color: Colors.blue)),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your updated Task';
                }
                return null;
              },
              controller: taskController,
              decoration: InputDecoration(hintText: 'Updated Task'),
            ),
            SizedBox(height: 10),
            TextFormField(
              onTap: () async {
                dateController.text = await showDate();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter  updated Date';
                }
                try {
                  DateFormat('dd-MM-yyyy').parseStrict(value);
                } catch (e) {
                  return 'Please enter a valid date (dd-MM-yyyy)';
                }
                return null;
              },
              controller: dateController,
              decoration: InputDecoration(hintText: 'Updated Date'),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: AppText(text: 'No'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  DateTime date = DateFormat(
                    'dd-MM-yyyy',
                  ).parseStrict(dateController.text);
                  final todo = Todo(
                    task: taskController.text,
                    date: date,
                    id: widget.id,
                  );
                  await controller.edit(todo);
                  await controller.getAll();

                  Get.back();
                }
              },
              child: AppText(text: 'Save'),
            ),
          ],
        ),
      ],
    );
  }
}
