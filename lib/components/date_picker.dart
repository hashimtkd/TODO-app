import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<String> showDate() async {
  DateTime? date = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
  );
  if (date == null) return "";
  var formatter = DateFormat('dd-MM-yyyy');
  String formattedDate = formatter.format(date);
  return formattedDate;
}
