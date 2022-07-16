import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/pages/create_room_page.dart';
import 'package:tictactoe/pages/game_page.dart';
import 'package:tictactoe/pages/home_page.dart';
import 'package:tictactoe/pages/join_room_page.dart';
import 'package:tictactoe/provider/room_provider.dart';
import 'package:tictactoe/util/page_color.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MyRoutes.homeRoute: (context) => const HomePage(),
          MyRoutes.createRoute: (context) => const CreateRoom(),
          MyRoutes.joinRoute: (context) => const JoinRoom(),
          MyRoutes.gameRoute: (context) => const GamePage(),
        },
        initialRoute: MyRoutes.homeRoute,
      ),
    );
  }
}
