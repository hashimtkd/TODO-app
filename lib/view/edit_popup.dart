import 'package:flutter/material.dart';
import 'package:todo_db/custom%20widgets/custom_widgets.dart';

void editPopup(
  BuildContext context,
  TextEditingController name,
  TextEditingController age,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: AppText(text: 'Edit your data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: age,
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
                onPressed: () {},
                child: AppText(text: 'Save'),
              ),
            ],
          ),
        ],
      );
    },
  );
}
