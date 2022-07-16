import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.purple,
            spreadRadius: 1.0,
            blurRadius: 8.0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            width * 0.98,
            height * 0.05,
          ),
          primary: Colors.purple,
        ),
        child: Text(
          text,
          style: const TextStyle(fontFamily: 'BalooBhai', fontSize: 25),
        ),
      ),
    );
  }
}
