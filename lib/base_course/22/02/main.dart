import 'package:desktop_window/desktop_window.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:toly_game/base_course/22/02/menu/pause.dart';
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
    return GameWidget<TolyGame>(game: TolyGame(),
      overlayBuilderMap:  {
        PauseMenu.menuId: (_,game) => PauseMenu(game: game),
      },
    );
  }
}
