import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:toly_game/utils/size_utils.dart';

import 'bricks_game.dart';
import 'overlayers/home_page.dart';
import 'overlayers/settings_page.dart';

main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: '宋体'
      ),
      home: GameWidget<BricksGame>.controlled(
          gameFactory: BricksGame.new,
        // game: BricksGame(),
          overlayBuilderMap: {
            'HomePage': (_, game) => HomePage(game: game),
            'Settings': (_, game) => SettingsPage(game: game),
            // 'GameOver': (_, game) => GameOver(game: game),
          },
        initialActiveOverlays: const ['HomePage'],
        // overlayBuilderMap: ,
      ),
    ),
  );
  SizeUtils.fullScreenMobile();
}
