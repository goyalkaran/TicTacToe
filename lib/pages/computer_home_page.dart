import 'package:flutter/material.dart';
import 'package:tictactoe/util/routes.dart';

import '../widget/custom_buttons.dart';
import '../widget/responsive_page.dart';

class ComputerHomePage extends StatelessWidget {
  const ComputerHomePage({Key? key}) : super(key: key);

  void easyRoom(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.easyGameRoute);
  }

  void hardRoom(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.hardGameRoute);
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
              onTap: () => easyRoom(context),
              text: 'Easy Room',
            ),
            SizedBox(
              height: height / 35,
            ),
            CustomButton(
              onTap: () => hardRoom(context),
              text: 'Hard Room',
            ),
          ],
        ),
      ),
    );
  }
}
