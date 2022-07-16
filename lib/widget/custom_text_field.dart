import 'package:flutter/material.dart';
import 'package:tictactoe/util/page_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.purple,
            blurRadius: 5.0,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextField(
        cursorColor: Colors.purple.shade400,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: bgColor,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'BalooBhai',
          ),
        ),
      ),
    );
  }
}
