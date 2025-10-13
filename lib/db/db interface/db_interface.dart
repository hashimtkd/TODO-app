import 'package:todo_db/model/user.dart';

abstract class DbInterface {
  void addUser(User user);
  void getAll();
  void edit(User user);
  void delete(User user);
  void deleteAll();
}
