import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'bricks.dart';
import '../bricks_game.dart';
import 'game_top_bar/brick_wall.dart';
import 'paddle.dart';

class BulletManager extends PositionComponent with HasGameRef<BricksGame> {

  void startShoot() async {
    addBullet();
    await Future.delayed(const Duration(milliseconds: 400));
    if (game.world.isShoot) {
      startShoot();
    }
  }

  void addBullet() {
    Paddle paddle = game.world.paddle;
    Bullet bullet1 = Bullet();
    bullet1.anchor = Anchor.bottomCenter;
    add(bullet1);
    bullet1.position = paddle.center -
        Vector2(-(paddle.width / 2 - 20), paddle.height / 2 + 4);

    Bullet bullet2 = Bullet();
    bullet2.anchor = Anchor.bottomCenter;
    add(bullet2);
    bullet2.position =
        paddle.center - Vector2((paddle.width / 2 - 20), paddle.height / 2 + 4);
  }
}

class Bullet extends PositionComponent with HasGameRef<BricksGame>, CollisionCallbacks {

  double speed = -400;
  @override
  FutureOr<void> onLoad() {

    size = Vector2(6, 14);
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(Offset.zero, const Offset(6, 14)),
          const Radius.circular(2),
        ),
        Paint()..color = Colors.white);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    if (speed == 0 || isRemoving) return;
    y += dt * speed;
    super.update(dt);
  }


  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Brick) {
      game.world.onBrickWillRemove(other);
    }
    if (other is BrickWall) {
      removeFromParent();
    }
  }
}
