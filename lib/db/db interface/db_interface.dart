import 'package:todo_db/model/user.dart';

abstract class DbInterface {
  void add(User user);
  void getAll();
  void edit(User user);
  void delete(User user);
  void deleteAll();
}
