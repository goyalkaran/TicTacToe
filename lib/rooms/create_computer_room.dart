import 'package:flutter/material.dart';
import 'package:tictactoe/util/routes.dart';

import '../widget/custom_buttons.dart';
import '../widget/custom_text.dart';
import '../widget/custom_text_field.dart';
import '../widget/responsive_page.dart';

class CreateComputerRoom extends StatefulWidget {
  const CreateComputerRoom({Key? key}) : super(key: key);

  @override
  State<CreateComputerRoom> createState() => _CreateComputerRoomState();
}

class _CreateComputerRoomState extends State<CreateComputerRoom> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  void computerRoom(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.computerHomeRoute);
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
                onTap: () => computerRoom(context),
                text: 'Create',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
