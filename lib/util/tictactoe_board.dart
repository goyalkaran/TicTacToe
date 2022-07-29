import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/resource/client_socket.dart';
import 'package:tictactoe/resource/socket_mathods.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({Key? key}) : super(key: key);

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketMethods _socketMethods = SocketMethods();
  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(
      index,
      roomDataProvider.roomData["_id"],
      roomDataProvider.displayElement,
    );
  }

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 1,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height * 0.7,
          maxWidth: 500,
        ),
        child: AbsorbPointer(
          absorbing: roomDataProvider.roomData["playerTurn"]["socketID"] !=
              _socketMethods.clientSocket.id,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => tapped(index, roomDataProvider),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        // width: 2,
                      ),
                    ),
                    child: Center(
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          roomDataProvider.displayElement[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color:
                                      roomDataProvider.displayElement[index] ==
                                              "X"
                                          ? Colors.purple
                                          : Colors.green,
                                  blurRadius: 40.0,
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
