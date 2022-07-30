import 'package:flutter/material.dart';
class HardGamePage extends StatefulWidget {
  const HardGamePage({Key? key}) : super(key: key);

  @override
  State<HardGamePage> createState() => _HardGamePageState();
}

class _HardGamePageState extends State<HardGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text("hard game"),
        ),
      ),
    );
  }
}
