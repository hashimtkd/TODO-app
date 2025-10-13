import 'package:flutter/material.dart';
import 'package:todo_db/custom%20widgets/custom_widgets.dart';
import 'package:todo_db/db/sqflite/db_functions.dart';
import 'package:todo_db/model/user.dart';

Future<void> editPopup(
  BuildContext context,
  String name,
  String age,
  int? key,
) async {
  final nameController = TextEditingController(text: name);
  final ageController = TextEditingController(text: age);

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: AppText(text: 'Edit your data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'age',
              ),
            ),
          ],
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
                  if (nameController.text.isEmpty &&
                      ageController.text.isEmpty) {
                    return;
                  }
                  final user = User(
                    name: nameController.text,
                    age: ageController.text,
                    id: key,
                  );
                  await DbFunctions().edit(user);
                  Navigator.pop(context);
                },
                child: AppText(text: 'Save'),
              ),
            ],
          ),
        ],
      );
    },
  );
}
