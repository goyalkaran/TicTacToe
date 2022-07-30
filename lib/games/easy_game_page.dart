import 'package:flutter/material.dart';

class EasyGamePage extends StatefulWidget {
  const EasyGamePage({Key? key}) : super(key: key);

  @override
  State<EasyGamePage> createState() => _EasyGamePageState();
}

class _EasyGamePageState extends State<EasyGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text("easy game"),
        ),
      ),
    );
  }
}
