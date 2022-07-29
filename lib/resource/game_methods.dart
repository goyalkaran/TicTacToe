import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/util/util_methods.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket clientSocket) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    List<String> displayElements = roomDataProvider.displayElement;
    String winner = "";

    if (displayElements[0] != "" &&
        displayElements[0] == displayElements[1] &&
        displayElements[0] == displayElements[2]) {
      winner = displayElements[0];
    } else if (displayElements[3] != "" &&
        displayElements[3] == displayElements[4] &&
        displayElements[3] == displayElements[5]) {
      winner = displayElements[3];
    } else if (displayElements[6] != "" &&
        displayElements[6] == displayElements[7] &&
        displayElements[6] == displayElements[8]) {
      winner = displayElements[6];
    } else if (displayElements[0] != "" &&
        displayElements[0] == displayElements[3] &&
        displayElements[0] == displayElements[6]) {
      winner = displayElements[0];
    } else if (displayElements[1] != "" &&
        displayElements[1] == displayElements[4] &&
        displayElements[1] == displayElements[7]) {
      winner = displayElements[1];
    } else if (displayElements[2] != "" &&
        displayElements[2] == displayElements[5] &&
        displayElements[2] == displayElements[8]) {
      winner = displayElements[2];
    } else if (displayElements[0] != "" &&
        displayElements[0] == displayElements[4] &&
        displayElements[0] == displayElements[8]) {
      winner = displayElements[0];
    } else if (displayElements[2] != "" &&
        displayElements[2] == displayElements[4] &&
        displayElements[2] == displayElements[6]) {
      winner = displayElements[2];
    } else if (roomDataProvider.filledBoxes == 9) {
      winner = "";
      showGameDialogBox(context, "DRAW");
    }
    if (winner != "") {
      if (roomDataProvider.player1.playerType == winner) {
        showGameDialogBox(
            context, "${roomDataProvider.player1.nickname} WINNER!!!");
        clientSocket.emit("winner", {
          "winnerSocketID": roomDataProvider.player1.socketID,
          "roomID": roomDataProvider.roomData["_id"],
        });
      } else {
        showGameDialogBox(
            context, "${roomDataProvider.player2.nickname} WINNER!!!");
        clientSocket.emit("winner", {
          "winnerSocketID": roomDataProvider.player2.socketID,
          "roomID": roomDataProvider.roomData["_id"],
        });
      }
    }
  }

  void clearBoard(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    for(int i=0;i<9;i++){
      roomDataProvider.updateDisplayElement(i, "");
    }
    roomDataProvider.updateFilledBoxes();
  }
}
