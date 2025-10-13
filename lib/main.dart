import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_db/db/hive/db_functoins.dart';
import 'package:todo_db/model/user.dart';
import 'package:todo_db/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
    Hive.registerAdapter(UserAdapter());
  }
  box = await Hive.openBox<User>('uesrDb');

  runApp(const MyApp());
}
