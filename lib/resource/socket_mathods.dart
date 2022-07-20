import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/resource/client_socket.dart';
import 'package:tictactoe/util/routes.dart';
import 'package:tictactoe/util/snack_bar.dart';

class SocketMethods {
  final _clientSocket = ClientSocket.instance.socket!;

  //EMITS
  //sending data from client to server
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _clientSocket.emit(
        "createRoom",
        {
          "nickname": nickname,
        },
      );
    }
  }

  void joinRoom(String nickname, String roomID) {
    if (nickname.isNotEmpty && roomID.isNotEmpty) {
      _clientSocket.emit("joinRoom", {
        "nickname": nickname,
        "roomID": roomID,
      });
    }
  }

  //LISTENERS
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

  void roomJoinedListener(BuildContext context) {
    _clientSocket.on(
      "roomJoined",
      (room) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(room);
        Navigator.pushNamed(context, MyRoutes.gameRoute);
      },
    );
  }

  void errorFoundListener(BuildContext context) {
    _clientSocket.on(
      "errorFound",
      (data) {
        showSnackBar(context, data);
      },
    );
  }

  void updateRoomListener(BuildContext context) {
    _clientSocket.on("updateRoom", (roomData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(roomData);
    });
  }

  void updatePlayerStateListener(BuildContext context) {
    _clientSocket.on("updatePlayer", (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }
}
