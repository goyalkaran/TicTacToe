import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/widget/custom_player.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    final double width = MediaQuery.of(context).size.width;
    final String player1=roomDataProvider.roomData["players"][0]["nickname"].toString();
    final String player2=roomDataProvider.roomData["players"][1]["nickname"].toString();
    String player1Points=roomDataProvider.roomData["players"][0]["points"].toString();
    String player2Points=roomDataProvider.roomData["players"][1]["points"].toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPlayer(
          playerNickname:player1,
          playerPoint: player1Points,
        ),
        CustomPlayer(
          playerNickname:player2,
          playerPoint: player2Points,
        ),
      ],
    );
  }
}
