import 'package:desktop_window/desktop_window.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'app/key.dart';
import 'menu/main.dart';

import 'game.dart';

main() {
  runApp(const GameApp());
  DesktopWindow.setWindowSize(Size(700,300));
}

class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Keys.navKey,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
        fontFamily: 'ZCOOLKuaiLe'
      ),
      home: const MainMenu(),
    );
  }
}


class GameWorld extends StatelessWidget {
  const GameWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: TolyGame());
  }
}
