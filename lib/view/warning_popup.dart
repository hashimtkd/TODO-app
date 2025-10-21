import 'package:flutter/material.dart';
import 'package:todo_db/custom%20widgets/custom_widgets.dart';

void warning(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure?', style: TextStyle(color: Colors.blue)),
        content: AppText(text: 'Quit without saving?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: Colors.blue)),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Yes', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ],
      );
    },
  );
}
