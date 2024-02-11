import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../game_world.dart';

class Player2Component extends SpriteComponent
    with HasGameRef<GameWorld>, CollisionCallbacks {
  Player2Component();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = Sprite(
      game.spriteImage,
      srcPosition: Vector2(1866, 6.0),
      srcSize:Vector2(114.0, 90.0),
    );

    position = Vector2(250, 50);
    // 添加矩形碰撞区
    addAll(createHitBoxes());
    updateColor(false);
  }

  void updateColor(bool active) {
    children.whereType<RectangleHitbox>().forEach((element) {
      element
        ..debugMode = true
        ..debugColor = active?Colors.blue:Colors.orange;
    });
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    updateColor(true);
  }

  List<RectangleHitbox> createHitBoxes() {
    return [
      RectangleHitbox.relative(
        Vector2(0.96, 0.42),
        position: Vector2(4, 36),
        parentSize: size,
      ),
      RectangleHitbox.relative(
        Vector2(0.3, 0.15),
        position: Vector2(24, height-16),
        parentSize: size,
      )
    ];
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    updateColor(false);
  }
}
