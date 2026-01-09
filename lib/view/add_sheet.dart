import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_db/components/app_text.dart';
import 'package:todo_db/components/app_textField.dart';
import 'package:todo_db/components/warning_popup.dart';
import 'package:todo_db/db/db%20functions/db_functions.dart';
import 'package:todo_db/model/todo.dart';

class AddSheet extends StatefulWidget {
  const AddSheet({super.key});

  @override
  State<AddSheet> createState() => _AddSheetState();
}

class _AddSheetState extends State<AddSheet> {
  final taskControl = TextEditingController();
  final dateControl = TextEditingController();
  final timeControl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white60,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await add(taskControl.text, dateControl.text);

            Navigator.pop(context);
          }
        },
        child: Icon(Icons.check),
      ),
      backgroundColor: Color.fromARGB(255, 148, 219, 250),
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 5,
        leading: IconButton(
          onPressed: () {
            warning(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Color.fromARGB(255, 148, 219, 250),
        title: AppText(text: 'New Task', fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  AppText(
                    text: 'What is to be done?',
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextfield(
                  controller: taskControl,
                  validation: 'Please enter your Task',
                  hintText: "Enter Task Here",
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  AppText(text: 'Due date', fontWeight: FontWeight.bold),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextfield(
                  textInputType: TextInputType.datetime,
                  controller: dateControl,
                  validation: 'Please enter date',
                  hintText: 'Date not set',
                  isDate: true,
                  onTap: () async {
                    await showDate();
                  },
                  onPressed: () async {
                    await showDate();
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  AppText(text: 'Due time', fontWeight: FontWeight.bold),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextfield(
                  isDate: false,
                  onTap: () async {
                    await showTime();
                  },
                  onPressed: () async {
                    await showTime();
                  },
                  controller: dateControl,
                  validation: 'Time not set',
                  hintText: 'Please enter time',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDate() async {
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
      dateControl.text = formattedDate;
    });
  }

  Future<void> showTime() async {
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  Future<void> add(String task, String date) async {
    if (task.isNotEmpty && date.isNotEmpty && timeControl.text.isNotEmpty) {
      DateTime _date = DateFormat('dd-MM-yyyy').parseStrict(date);
      final todo = Todo(task: task, date: _date);
      await DbFunctions().add(todo);
    }
  }
}
