import 'package:flutter/material.dart';
import 'package:todo_db/custom%20widgets/custom_widgets.dart';
import 'package:todo_db/view/add_sheet.dart';
import 'package:todo_db/view/edit_popup.dart';
import 'package:todo_db/view/warning_popup.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white60,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,

            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsetsGeometry.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: addSheet(context),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,

      appBar: AppBar(
        leading: IconButton(
          style: ButtonStyle(iconSize: WidgetStatePropertyAll(40)),
          onPressed: () {
            warning(context);
          },
          icon: Icon(Icons.delete_forever),
        ),
        title: AppText(text: 'My TODO', size: 25),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: AppText(
                          text: 'Hashim',
                          size: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        subtitle: AppText(text: '25'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                editPopup(context, name, age);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },

                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
