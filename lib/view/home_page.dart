import 'package:flutter/material.dart';
import 'package:todo_db/custom%20widgets/custom_widgets.dart';
import 'package:todo_db/db/hive/db_functoins.dart';
import 'package:todo_db/view/add_sheet.dart';
import 'package:todo_db/view/edit_popup.dart';
import 'package:todo_db/view/warning_popup.dart';

final GlobalKey<_HomePageState> homePageKey = GlobalKey<_HomePageState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My TODO',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(key: homePageKey),
    );
  }
}

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
    await DbFunctoins().getAll();
    setState(() {});
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
                padding: EdgeInsets.only(
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
          onPressed: () async {
            warning(context);
            await loadAll();
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
              child: userList.isEmpty
                  ? Center(child: AppText(text: 'Data not found try to add'))
                  : ListView.builder(
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
                                      editPopup(
                                        context,
                                        userList[index].name,
                                        userList[index].age,
                                        userList[index].key,
                                      );
                                      await loadAll();
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await DbFunctoins().delete(list);
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
