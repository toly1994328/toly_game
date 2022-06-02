import 'package:desktop_window/desktop_window.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game.dart';

main() {
  runApp(GameWidget(game: TolyGame(),));
  DesktopWindow.setWindowSize(const Size(700,300));
}


