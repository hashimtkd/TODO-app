import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_db/components/app_text.dart';
import 'package:todo_db/components/edit_popup.dart';
import 'package:todo_db/controllers/todo_controller.dart';
import 'package:todo_db/view/add_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoController controller = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white60,
        onPressed: () async {
          Get.to(() => AddSheet());
        },
        child: const Icon(Icons.add),
      ),

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 148, 219, 250),
        title: const AppText(text: 'TODO LIST', fontWeight: FontWeight.w500),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 5,
      ),

      drawer: const Drawer(),
      body: Obx(() {
        return controller.todoList.isEmpty
            ? Stack(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 148, 219, 250),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset('assets/image/todo back.png'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: const Center(
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
                    final list = controller.todoList[index];
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
                                        task: list.task,
                                        date: list.date,
                                        id: list.id,
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await controller.delete(
                                    controller.todoList[index].id,
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },

                  itemCount: controller.todoList.length,
                ),
              );
      }),
    );
  }
}
