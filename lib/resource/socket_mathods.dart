import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/resource/client_socket.dart';
import 'package:tictactoe/util/routes.dart';

class SocketMethods {
  final _clientSocket = ClientSocket.instance.socket!;

  //sending data from client to server
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _clientSocket.emit("createRoom", {
        "nickname": nickname,
      });
    }
  }

  void roomCreatedListener(BuildContext context) {
    _clientSocket.on(
      "roomCreated",
      (room) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(room);
        Navigator.pushNamed(context, MyRoutes.gameRoute);
      },
    );
  }
}
