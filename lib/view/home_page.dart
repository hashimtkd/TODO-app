import 'package:flutter/material.dart';
import 'package:todo_db/custom%20widgets/custom_widgets.dart';
import 'package:todo_db/db/sqflite/db_functions.dart';
import 'package:todo_db/view/add_sheet.dart';
import 'package:todo_db/view/edit_popup.dart';
import 'package:todo_db/view/warning_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadAll();
  }

  Future<void> loadAll() async {
    await DbFunctions().getAll().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white60,
        onPressed: () async {
          await showModalBottomSheet(
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
          await loadAll();
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
                  final list = userList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: AppText(
                          text: list.name,
                          size: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        subtitle: AppText(text: list.age),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await editPopup(
                                  context,
                                  list.name,
                                  list.age,
                                  list.id,
                                );
                                await loadAll();
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await DbFunctions().delete(userList[index]);
                                await loadAll();
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },

                itemCount: userList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
