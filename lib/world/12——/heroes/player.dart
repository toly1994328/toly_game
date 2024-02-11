import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../game_world.dart';

class PlayerComponent extends SpriteComponent with HasGameRef<GameWorld>, CollisionCallbacks {
  PlayerComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = Sprite(
      game.spriteImage,
      srcPosition: Vector2(1514.0, 4.0),
      srcSize: Vector2(88.0, 90.0),
    );
    position = Vector2(100, 50);
    // 添加矩形碰撞区
    RectangleHitbox rHitBox = RectangleHitbox();
    rHitBox..debugMode = true..debugColor = Colors.orange;
    add(rHitBox);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    children.first.debugColor = Colors.blue;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    children.first.debugColor = Colors.orange;
  }
}
