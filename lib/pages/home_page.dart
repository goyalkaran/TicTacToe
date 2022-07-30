import 'package:flutter/material.dart';
import 'package:tictactoe/util/routes.dart';
import 'package:tictactoe/widget/custom_buttons.dart';
import 'package:tictactoe/widget/responsive_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.createRoute);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.joinRoute);
  }

  void createComputerRoom(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.createComputerRoute);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => createRoom(context),
              text: 'Create Room',
            ),
            SizedBox(
              height: height / 35,
            ),
            CustomButton(
              onTap: () => joinRoom(context),
              text: 'Join Room',
            ),
            SizedBox(
              height: height / 35,
            ),
            CustomButton(
              onTap: () => createComputerRoom(context),
              text: 'Computer',
            ),
          ],
        ),
      ),
    );
  }
}
