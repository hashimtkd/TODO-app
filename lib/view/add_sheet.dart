import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_db/components/app_text.dart';
import 'package:todo_db/components/app_textField.dart';
import 'package:todo_db/components/warning_popup.dart';
import 'package:todo_db/controllers/todo_controller.dart';

class AddSheet extends StatefulWidget {
  const AddSheet({super.key});

  @override
  State<AddSheet> createState() => _AddSheetState();
}

class _AddSheetState extends State<AddSheet> {
  final _formKey = GlobalKey<FormState>();

  TodoController controller = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white60,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            controller.add();

            Get.back();
          }
        },
        child: Icon(Icons.check),
      ),
      backgroundColor: Color.fromARGB(255, 148, 219, 250),
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 5,
        leading: IconButton(
          onPressed: () {
            warning(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Color.fromARGB(255, 148, 219, 250),
        title: const AppText(text: 'New Task', fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                children: [
                  AppText(
                    text: 'What is to be done?',
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextfield(
                  controller: controller.taskControl,
                  validation: 'Please enter your Task',
                  hintText: "Enter Task Here",
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  AppText(text: 'Due date', fontWeight: FontWeight.bold),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextfield(
                  textInputType: TextInputType.datetime,
                  controller: controller.dateControl,
                  validation: 'Please enter date',
                  hintText: 'Date not set',
                  isDate: true,
                  onTap: () async {
                    await controller.showDateController();
                  },
                  onPressed: () async {
                    await controller.showDateController();
                  },
                ),
              ),
              const SizedBox(height: 10),
              //const Row(
              //children: [
              //AppText(text: 'Due time', fontWeight: FontWeight.bold),
              //],
              // ),
              //Padding(
              // padding: const EdgeInsets.all(8.0),
              // child: AppTextfield(
              //  isDate: false,
              // onTap: () async {
              // await controller.showTime();
              // },
              // onPressed: () async {
              // await controller.showTime();
              // },
              // controller: controller.dateControl,
              // validation: 'Time not set',
              // hintText: 'Please enter time',
              //),
              //),
            ],
          ),
        ),
      ),
    );
  }
}
