import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/pages/waiting_page.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/resource/socket_mathods.dart';
import 'package:tictactoe/board/score_board.dart';
import 'package:tictactoe/board/tictactoe_board.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updatePlayerStateListener(context);
    _socketMethods.updateRoomListener(context);
    _socketMethods.pointIncrementListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: roomDataProvider.roomData["isJoin"]
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ScoreBoard(),
                  TicTacToeBoard(),
                  Text(
                      "${roomDataProvider.roomData["playerTurn"]["nickname"]}'s"),
                ],
              ),
            ),
    );
  }
}
