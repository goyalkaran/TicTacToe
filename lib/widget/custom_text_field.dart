import 'package:flutter/material.dart';
import 'package:tictactoe/util/page_utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isReadOnly;
  final String hintText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isReadOnly=false,
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
        readOnly: isReadOnly,
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
