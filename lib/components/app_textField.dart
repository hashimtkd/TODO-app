import 'package:flutter/material.dart';

class AppTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String validation;
  final String hintText;
  GestureTapCallback? onTap;
  GestureTapCallback? onPressed;
  bool? isDate;
  TextInputType? textInputType;

  AppTextfield({
    super.key,
    required this.controller,
    required this.validation,
    this.onTap,
    required this.hintText,
    this.onPressed,
    this.isDate,
    this.textInputType,
  });

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validation;
        }

        return null;
      },
      controller: widget.controller,
      onTap: widget.onTap,
      decoration: InputDecoration(
        suffixIcon: widget.isDate == null
            ? null
            : IconButton(
                onPressed: widget.onPressed,
                icon: widget.isDate == true
                    ? Icon(Icons.calendar_month)
                    : Icon(Icons.watch_rounded),
              ),
        hintText: widget.hintText,
      ),
    );
  }
}
