import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_db/controllers/todo_controller.dart';
import 'package:todo_db/db/db%20functions/db_functions.dart';
import 'package:todo_db/model/todo.dart';
import 'package:todo_db/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TodoAdapter().typeId)) {
    Hive.registerAdapter(TodoAdapter());
  }

  hiveBox = await Hive.openBox<Todo>('todo');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(TodoController());
      }),
      debugShowCheckedModeBanner: false,
      title: 'My TODO',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}
