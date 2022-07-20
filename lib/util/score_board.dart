import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/widget/custom_player.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    // print(roomDataProvider.player1.nickname);
    // print(roomDataProvider.player2.nickname);
    final double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomPlayer(
          playerNickname: roomDataProvider.player1.nickname,
          playerPoint: roomDataProvider.player1.points.toInt().toString(),
        ),
        SizedBox(
          width: width * 0.45,
        ),
        CustomPlayer(
          playerNickname: roomDataProvider.player2.nickname,
          playerPoint: roomDataProvider.player2.points.toInt().toString(),
        ),
      ],
    );
  }
}
