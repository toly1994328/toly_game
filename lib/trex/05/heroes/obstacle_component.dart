import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

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

  final Random random = Random(8);

  /// 随机生成障碍物
  void addObstacle() {
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
addAll([
  RectangleHitbox(
    position: Vector2(5.0, 7.0),
    size: Vector2(10.0, 54.0),
  )..debugMode=true,
  RectangleHitbox(
    position: Vector2(5.0, 7.0),
    size: Vector2(12.0, 68.0),
  )..debugMode=true,
  RectangleHitbox(
    position: Vector2(15.0, 4.0),
    size: Vector2(14.0, 28.0),
  )..debugMode=true
]);
    sprite = Sprite(
      game.spriteImage,
      srcPosition: position,
      srcSize: size,
    );
    // debugMode=true;

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
      1 => 20,
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
    debugMode=true;
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
