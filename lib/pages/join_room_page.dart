import 'package:flutter/material.dart';
import '../widget/custom_buttons.dart';
import '../widget/custom_text.dart';
import '../widget/custom_text_field.dart';
import '../widget/responsive_page.dart';

class JoinRoom extends StatefulWidget {
  const JoinRoom({Key? key}) : super(key: key);

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [
                  Shadow(
                    color: Colors.purple,
                    blurRadius: 80.0,
                  ),
                ],
                text: 'Join Room',
                fontSize: 105.0,
              ),
              SizedBox(
                height: height / 25,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter Your Nickname',
              ),
              SizedBox(
                height: height *0.02,
              ),
              CustomTextField(
                controller: _roomController,
                hintText: 'Enter Room ID',
              ),
              SizedBox(
                height: height / 30,
              ),
              CustomButton(
                onTap: () {},
                text: 'Join',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
