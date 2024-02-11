import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../game_world.dart';

class PlayerComponent extends SpriteComponent
    with HasGameRef<GameWorld>, CollisionCallbacks {
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
        Vector2(0.45, 0.35),
        position: Vector2(4, 0),
        anchor: const Anchor(-1,0),
        parentSize: size,
      ),
      RectangleHitbox.relative(
        Vector2(0.66, 0.45),
        position: Vector2(4, 32),
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
