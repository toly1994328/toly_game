import 'package:desktop_window/desktop_window.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'toly_game.dart';

main() {
  runApp(GameWidget(game: TolyGame()));
  DesktopWindow.setWindowSize(Size(700,300));

}
