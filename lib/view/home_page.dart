import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_db/custom%20widgets/custom_widgets.dart';
import 'package:todo_db/db/db%20interface/hive/db%20functions/db_functions.dart';
import 'package:todo_db/view/add_sheet.dart';
import 'package:todo_db/view/edit_popup.dart';

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
    await DbFunctions().getAll().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white60,
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return AddSheet();
              },
            ),
          );
          setState(() {});
        },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 148, 219, 250),
        title: AppText(text: 'TODO LIST', fontWeight: FontWeight.w500),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 5,
      ),
      body: todoList.isEmpty
          ? Stack(
              children: [
                Container(
                  color: const Color.fromARGB(255, 148, 219, 250),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset('lib/assets/image/todo back.png'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: " Your TODO List is empty ",
                          size: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        AppText(
                          text:
                              ' A blank list is the beginning of new achievements.',
                        ),
                        AppText(
                          text: ' "Start now!"',
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(
              color: const Color.fromARGB(255, 148, 219, 250),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final list = todoList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: const Color.fromARGB(255, 88, 163, 196),
                      child: ListTile(
                        title: AppText(
                          text: list.task,
                          size: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        subtitle: AppText(
                          text: DateFormat('dd-MM-yyyy').format(list.date),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditPopup(
                                      task: todoList[index].task,
                                      date: todoList[index].date,
                                      id: todoList[index].id,
                                    );
                                  },
                                );

                                setState(() {});
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await DbFunctions().delete(list.id);
                                setState(() {});
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },

                itemCount: todoList.length,
              ),
            ),
    );
  }
}
