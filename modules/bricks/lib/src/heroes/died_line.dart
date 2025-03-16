import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../bricks_game.dart';
import 'ball.dart';

class DiedLine extends SpriteAnimationComponent
    with HasGameRef<BricksGame>, CollisionCallbacks {
  @override
  FutureOr<void> onLoad() {
    final List<Sprite> spriteList = [];
    for (int i = 1; i <= 4; i++) {
      String name = 'lightning${i.toString().padLeft(2, '0')}.png';
      spriteList.add(game.loader[name]);
    }

    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.1,
      loop: true,
    );
    size = Vector2(kViewPort.width, 40);

    position = Vector2(0, kViewPort.height - height - 40);

    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ball) {
      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
