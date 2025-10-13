import 'package:hive/hive.dart';
import 'package:todo_db/db/db%20interface/db_interface.dart';
import 'package:todo_db/model/user.dart';
import 'package:todo_db/view/home_page.dart';

Box? box;
List userList = [];
final load = homePageKey.currentState?.loadAll();

class DbFunctoins implements DbInterface {
  @override
  Future<void> addUser(User user) async {
    final int key = await box!.add(user);
    user.key = key;

    await getAll();
  }

  @override
  Future<void> delete(User user) async {
    await box!.delete(user.key);
  }

  @override
  Future<void> deleteAll() async {
    await box!.clear();
    userList.clear();
  }

  @override
  Future<void> edit(User user) async {
    await box!.put(user.key, user);
  }

  @override
  Future<void> getAll() async {
    final _list = box!.values.toList();

    userList.clear();
    userList.addAll(_list.cast<User>());
  }
}
