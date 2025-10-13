import 'package:flutter/material.dart';
import 'package:todo_db/custom%20widgets/custom_widgets.dart';
import 'package:todo_db/db/hive/db_functoins.dart';
import 'package:todo_db/model/user.dart';
import 'package:todo_db/view/home_page.dart';

void editPopup(BuildContext context, String name, String age, int key) async {
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
                  final user = User(
                    name: nameController.text,
                    age: ageController.text,
                    key: key,
                  );

                  await DbFunctoins().edit(user);
                  await homePageKey.currentState?.loadAll();

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
