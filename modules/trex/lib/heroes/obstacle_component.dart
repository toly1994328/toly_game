import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../trex_game.dart';

class ObstacleManager extends PositionComponent
    with HasGameReference<TrexGame> {
  @override
  void update(double dt) {
    super.update(dt);
    if (children.isNotEmpty) {
      final lastCloud = children.last as PositionComponent;
      double lastPosX = lastCloud.x + lastCloud.size.x;
      if (game.size.x - lastPosX > 0) {
        addObstacle();
      }
    } else {
      addObstacle();
    }
  }

  /// 随机生成障碍物
  void addObstacle() {
    Random random = game.random;
    int value = random.nextInt(100);
    PositionComponent obstacle;
    if (value < 20) {
      obstacle = AnimaObstacleComponent(random.nextInt(3));
    } else {
      obstacle = ObstacleComponent(random.nextInt(4));
    }
    double gap = 800 * (0.4 + 0.6 * random.nextDouble());
    if (children.isEmpty) {
      obstacle.x = gap;
    } else {
      obstacle.x = (children.last as PositionComponent).x + gap;
    }
    add(obstacle);
  }

  void restart() {
    x = 0;
    removeWhere((component) => true);
  }
}

class ObstacleComponent extends SpriteComponent
    with HasGameReference<TrexGame> {
  final int type;
  ObstacleComponent(this.type);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    double offset = switch (type) {
      0 => 40,
      1 => 60,
      2 => 40,
      _ => 60,
    };
    y = size.y - 70.0 - offset;
  }

  @override
  Future<void> onLoad() async {
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
    this.size = size;

    sprite = Sprite(
      game.spriteImage,
      srcPosition: position,
      srcSize: size,
    );

    List<RectangleHitbox> boxes = createHitBoxesByType(type);
    // debugHitBoxes(boxes);
    addAll(boxes);
  }

  void debugHitBoxes(List<RectangleHitbox> boxes) {
    for (RectangleHitbox box in boxes) {
      box.debugMode = true;
      box.debugColor = Colors.orange;
    }
  }

  List<RectangleHitbox> createHitBoxesByType(int type) {
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
  void update(double dt) {
    super.update(dt);
    if (isRemoving) return;
    x -= game.moveSpeed * dt;
    if (x + width < 0) {
      removeFromParent();
    }
  }
}

class AnimaObstacleComponent extends SpriteAnimationComponent
    with HasGameReference<TrexGame> {
  final int type;

  AnimaObstacleComponent(this.type);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    double offset = switch (type) {
      0 => 80,
      1 => 5,
      _ => -50,
    };
    y = size.y - 180 + offset;
  }

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
    add(
      RectangleHitbox.relative(
        Vector2(0.7, 0.6),
        position: position,
        parentSize: size,
      ),
    );
    List<RectangleHitbox> boxes = createHitBoxes();
    // debugHitBoxes(boxes);
    addAll(boxes);
  }

  void debugHitBoxes(List<RectangleHitbox> boxes) {
    for (RectangleHitbox box in boxes) {
      box.debugMode = true;
      box.debugColor = Colors.orange;
    }
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
  void update(double dt) {
    super.update(dt);
    if (isRemoving) return;
    x -= game.moveSpeed * dt;
    if (x + width < 0) {
      removeFromParent();
    }
  }
}
