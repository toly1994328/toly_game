import 'dart:async';

import 'package:flame/components.dart';

import '../bricks_game.dart';

class Paddle extends SpriteComponent with HasGameRef<BricksGame>{

  @override
  FutureOr<void> onLoad() {
    sprite = game.loader['Paddle_A_Blue_96x28.png'];
    return super.onLoad();
  }
}