import 'dart:async';

import 'package:flame/components.dart';

import '../bricks_game.dart';

class Brick extends SpriteComponent with HasGameRef<BricksGame>{

  @override
  FutureOr<void> onLoad() {
    sprite = game.loader['Colored_Blue-128x32.png'];
    return super.onLoad();
  }
}