import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../bricks_game.dart';

class Paddle extends SpriteComponent with HasGameRef<BricksGame> {
  @override
  FutureOr<void> onLoad() {
    sprite = game.loader['Paddle_A_Blue_96x28.png'];
    add(RectangleHitbox());
    y = kViewPort.height - 100;
    x = kViewPort.width / 2 - width / 2;
    return super.onLoad();
  }

  void moveBy(double dx) {
    double newX = position.x + dx;
    if (newX < 0) {
      x = 0;
      return;
    }
    if (newX > game.size.x - width) {
      x = game.size.x - width;
      return;
    }
    add(MoveToEffect(
      Vector2(newX, position.y),
      EffectController(duration: 0.1),
    ));
  }
}
