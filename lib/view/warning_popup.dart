import 'package:flutter/material.dart';
import 'package:todo_db/custom%20widgets/custom_widgets.dart';

void warning(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: AppText(text: 'Warning!')),
        content: AppText(text: 'Are you sure you want to delete all items?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: AppText(text: 'No'),
              ),

              TextButton(
                onPressed: () {},
                child: AppText(text: 'Yes'),
              ),
            ],
          ),
        ],
      );
    },
  );
}
