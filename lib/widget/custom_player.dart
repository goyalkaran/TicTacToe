import 'package:flutter/material.dart';

class CustomPlayer extends StatelessWidget {
  final String playerNickname;
  final String playerPoint;
  const CustomPlayer({
    Key? key,
    required this.playerNickname,
    required this.playerPoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String s = playerNickname[0].toUpperCase();
    final String s1 = playerNickname.substring(1).toLowerCase();
    final String playerName = s + s1;
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            playerName,
            style: const TextStyle(
              fontFamily: "BalooBhai",
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            playerPoint,
            style: const TextStyle(
              fontFamily: "BalooBhai",
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
