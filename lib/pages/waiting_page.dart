import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/widget/custom_text_field.dart';
import 'package:tictactoe/widget/responsive_page.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({Key? key}) : super(key: key);

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController _gameIDController;
  @override
  void initState() {
    super.initState();
    _gameIDController = TextEditingController(
      text: Provider.of<RoomDataProvider>(context, listen: false)
          .roomData["_id"]
          .toString(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _gameIDController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Waiting for the other player to join."),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          Container(
            width:MediaQuery.of(context).size.width/0.15 ,
            child: CustomTextField(
              controller: _gameIDController,
              hintText: '',
              isReadOnly: true,
            ),
          ),
        ],
      ),
    );
  }
}
