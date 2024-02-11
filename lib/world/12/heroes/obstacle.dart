import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../game_world.dart';

class ObstacleComponent extends SpriteComponent
    with HasGameRef<GameWorld>, CollisionCallbacks {
  final int type;

  ObstacleComponent(this.type);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    Vector2 position = switch (type) {
      0 => Vector2(446.0, 2.0),
      1 => Vector2(652.0, 2.0),
      2 => Vector2(513.0, 2.0),
      _ => Vector2(849.0, 2.0),
    };
    Vector2 size = switch (type) {
      0 => Vector2(34.0, 70.0),
      1 => Vector2(50.0, 100.0),
      2 => Vector2(70.0, 70.0),
      _ => Vector2(100.0, 100.0),
    };

    sprite = Sprite(
      game.spriteImage,
      srcPosition: position,
      srcSize: size,
    );

    Vector2 pos = switch (type) {
      0 => Vector2(100, 180),
      1 => Vector2(100 + 150, 180),
      2 => Vector2(100 + 150 * 2, 180),
      _ => Vector2(100 + 150 * 3, 180),
    };

    this.position = pos;
    // 添加矩形碰撞区
    addAll(createHitBoxes());
    updateColor(false);
  }

  void updateColor(bool active) {
    children.whereType<RectangleHitbox>().forEach((element) {
      element
        ..debugMode = true
        ..debugColor = active ? Colors.blue : Colors.orange;
    });
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    updateColor(true);
  }

  List<RectangleHitbox> createHitBoxes() {
    if (type == 0 || type == 1) {
      return [
        RectangleHitbox.relative(
          Vector2(0.24, 1), // position: Vector2(4, 36),
          parentSize: size,
        ),
        RectangleHitbox.relative(
          Vector2(1, 0.4), anchor: const Anchor(0, -1),
          position: Vector2(0, -height * 0.16),
          // position: Vector2(4, 36),
          parentSize: size,
        ),
      ];
    }
    if (type == 2) {
      return [
        RectangleHitbox.relative(
          Vector2(0.64, 1), // position: Vector2(4, 36),
          parentSize: size,
        ),
        RectangleHitbox.relative(
          Vector2(1, 0.4), anchor: const Anchor(0, -1),
          position: Vector2(0, -height * 0.16),
          // position: Vector2(4, 36),
          parentSize: size,
        ),
      ];
    }
    return [
      RectangleHitbox.relative(
        Vector2(0.68, 1), // position: Vector2(4, 36),
        parentSize: size,
      ),
      RectangleHitbox.relative(
        Vector2(1, 0.4), anchor: const Anchor(0, -1),
        position: Vector2(0, -height * 0.16),
        // position: Vector2(4, 36),
        parentSize: size,
      ),
    ];
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    updateColor(false);
  }
}

class AnimaObstacleComponent extends SpriteAnimationComponent
    with HasGameRef<GameWorld>, CollisionCallbacks {
  final int type;

  AnimaObstacleComponent(this.type);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.spriteList(
      [Vector2(263.0, 9.0), Vector2(355.0, 9.0)]
          .map((vector) => Sprite(
                game.spriteImage,
                srcSize: Vector2(90, 64),
                srcPosition: vector,
              ))
          .toList(),
      stepTime: 0.2,
    );

    position = Vector2(450, 50);

    addAll(createHitBoxes());
    updateColor(false);
  }

  void updateColor(bool active) {
    children.whereType<RectangleHitbox>().forEach((element) {
      element
        ..debugMode = true
        ..debugColor = active ? Colors.blue : Colors.orange;
    });
  }

  List<RectangleHitbox> createHitBoxes() {
    return [
      RectangleHitbox.relative(
        Vector2(0.32, 0.33),
        position: Vector2(0, 8),
        parentSize: size,
      ),
      RectangleHitbox.relative(
        Vector2(0.32, 1),
        position: Vector2(0.32 * width, 0),
        parentSize: size,
      ),
      RectangleHitbox.relative(
        Vector2(0.32, 0.25),
        position: Vector2(0.64 * width, 0.5 * height),
        parentSize: size,
      )
    ];
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    updateColor(true);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    updateColor(false);
  }
}
