import 'package:desktop_window/desktop_window.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'game.dart';

main() {
  runApp(GameWidget(game: TolyGame(),));
  DesktopWindow.setWindowSize(Size(700,300));
}


