import 'package:flutter/material.dart';
import 'package:tictactoe/resource/socket_mathods.dart';
import 'package:tictactoe/widget/custom_buttons.dart';
import 'package:tictactoe/widget/custom_text.dart';
import 'package:tictactoe/widget/custom_text_field.dart';
import 'package:tictactoe/widget/responsive_page.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.roomCreatedListener(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
  }

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
                text: 'Create Room',
                fontSize: 95.0,
              ),
              SizedBox(
                height: height / 25,
              ),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter Your Nickname',
              ),
              SizedBox(
                height: height / 30,
              ),
              CustomButton(
                onTap: () {
                  _socketMethods.createRoom(
                    _nameController.text,
                  );
                },
                text: 'Create',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
