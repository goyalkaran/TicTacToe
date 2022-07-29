import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/resource/client_socket.dart';
import 'package:tictactoe/resource/game_methods.dart';
import 'package:tictactoe/util/routes.dart';
import 'package:tictactoe/util/util_methods.dart';

class SocketMethods {
  final _clientSocket = ClientSocket.instance.socket!;

  Socket get clientSocket => _clientSocket;

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

  void tapGrid(int index, String roomID, List<String> displayElement) {
    if (displayElement[index] == "") {
      _clientSocket.emit("tap", {
        "index": index,
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
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
        playerData,
      );
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
        playerData[0],
      );
    });
  }

  void tappedListener(BuildContext context) {
    _clientSocket.on("tapped", (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateDisplayElement(
        data["index"],
        data["choice"],
      );
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(
        data["room"],
      );
      GameMethods().checkWinner(context, _clientSocket);
    });
  }

  void pointIncrementListener(BuildContext context) {
    _clientSocket.on("pointIncrement", (playerData) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      if (roomDataProvider.player1.socketID == playerData["socketID"]) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _clientSocket.on("endGame", (playerData) {
      showGameDialogBox(context, "${playerData["nickname"]} won the game!");
      Navigator.pushNamed(context, MyRoutes.homeRoute);
    });
  }
}
