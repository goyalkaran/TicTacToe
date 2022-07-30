import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/pages/computer_home_page.dart';
import 'package:tictactoe/rooms/create_computer_room.dart';
import 'package:tictactoe/rooms/create_room_page.dart';
import 'package:tictactoe/games/easy_game_page.dart';
import 'package:tictactoe/games/game_page.dart';
import 'package:tictactoe/games/hard_game_page.dart';
import 'package:tictactoe/pages/home_page.dart';
import 'package:tictactoe/rooms/join_room_page.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/util/page_utils.dart';
import 'package:tictactoe/util/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Tic Tac Toe',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MyRoutes.homeRoute: (context) => const HomePage(),
          MyRoutes.createRoute: (context) => const CreateRoom(),
          MyRoutes.joinRoute: (context) => const JoinRoom(),
          MyRoutes.gameRoute: (context) => const GamePage(),
          MyRoutes.computerHomeRoute: (context) => const ComputerHomePage(),
          MyRoutes.easyGameRoute: (context) => const EasyGamePage(),
          MyRoutes.hardGameRoute: (context) => const HardGamePage(),
          MyRoutes.createComputerRoute: (context) => const CreateComputerRoom(),
        },
        initialRoute: MyRoutes.homeRoute,
      ),
    );
  }
}
