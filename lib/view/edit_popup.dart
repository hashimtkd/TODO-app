// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_db/custom%20widgets/custom_widgets.dart';
import 'package:todo_db/db/db%20interface/sqflite/db%20functions/db_functions.dart';
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
              onTap: () => showDate(),
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
                  DateTime _date = DateFormat(
                    'dd-MM-yyyy',
                  ).parseStrict(dateController.text);
                  final todo = Todo(
                    task: taskController.text,
                    date: _date,
                    id: widget.id,
                  );
                  await DbFunctions().edit(todo);
                  await DbFunctions().getAll();

                  Navigator.pop(context);
                }
              },
              child: AppText(text: 'Save'),
            ),
          ],
        ),
      ],
    );
  }

  void showDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (date == null) return;
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(date);
    setState(() {
      dateController.text = formattedDate;
    });
  }
}
