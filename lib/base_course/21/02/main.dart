import 'package:desktop_window/desktop_window.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'parallax_example.dart';

main() {
  runApp(GameWidget(game: BasicParallaxExample()));
  DesktopWindow.setWindowSize(Size(700,300));

}
