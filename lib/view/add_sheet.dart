import 'package:flutter/material.dart';
import 'package:todo_db/custom%20widgets/custom_widgets.dart';

final name = TextEditingController();
final age = TextEditingController();
Widget? addSheet(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      color: Colors.white,
    ),

    width: 300,
    height: 250,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(hintText: 'name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: age,
              decoration: InputDecoration(hintText: 'age'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: AppText(text: 'Add'),
            ),
          ],
        ),
      ),
    ),
  );
}
