import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final List<Shadow> shadows;
  final String text;
  final double fontSize;
  const CustomText(
      {Key? key,
      required this.shadows,
      required this.text,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.purple.shade50,
        fontSize: fontSize,
        fontFamily: 'BalooBhai',
        fontWeight: FontWeight.bold,
        shadows: shadows,
      ),
    );
  }
}
