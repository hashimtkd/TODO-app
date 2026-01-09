import 'package:flutter/widgets.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  const AppText({super.key, required this.text, this.size, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, fontWeight: fontWeight),
    );
  }
}
