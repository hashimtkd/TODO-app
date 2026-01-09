import 'package:flutter/material.dart';
import 'package:todo_db/components/app_text.dart';
import 'package:todo_db/view/home_page.dart';

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
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
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
