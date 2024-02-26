import 'dart:async';

import 'package:flame/components.dart';

import '../bricks_game.dart';

class Ball extends SpriteComponent with HasGameRef<BricksGame>{
  @override
  FutureOr<void> onLoad() {
    sprite = game.loader['Ball_Blue_Shiny-32x32.png'];
    return super.onLoad();
  }
}