import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../trex_game.dart';

enum PlayerState {
  waiting, // 等待
  running, // 奔跑
  jumping, // 跳跃
  down, // 趴下
  crashed, // 死亡
}

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameReference<TrexGame>, CollisionCallbacks {
  double get centerY {
    return (game.size.y / 2) - height / 2;
  }

  double initY = 0;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    initY = game.size.y - height - 40;
    y = initY;
    x = 60;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    game.gameOver();
  }

  double vY = 0; // 竖直速度
  double aY = 9.8 * 200; // 竖直加速度
  double sY = 0; // 竖直位移

  late final List<RectangleHitbox> _downHitBoxes = [
    RectangleHitbox.relative(
      Vector2(0.96, 0.42),
      position: Vector2(4, 36),
      parentSize: size,
    ),
    RectangleHitbox.relative(
      Vector2(0.3, 0.15),
      position: Vector2(24, height - 16),
      parentSize: size,
    )
  ];

  late final List<RectangleHitbox> _customHitBoxes = [
    RectangleHitbox.relative(
      Vector2(0.45, 0.35),
      position: Vector2(4, 0),
      anchor: const Anchor(-1, 0),
      parentSize: size,
    ),
    RectangleHitbox.relative(
      Vector2(0.66, 0.3),
      position: Vector2(4, 32),
      parentSize: size,
    ),
    RectangleHitbox.relative(
      Vector2(0.35, 0.28),
      position: Vector2(22, height - 30),
      parentSize: size,
    )
  ];

  void switchHitBoxByState(PlayerState? newState, PlayerState? oldState) {
    if (newState == PlayerState.down && oldState != PlayerState.down) {
      // 新状态是蹲下，修改碰撞区域
      removeWhere((component) => component is RectangleHitbox);
      addAll(_downHitBoxes);
    }

    if (oldState == PlayerState.down && newState != PlayerState.down ||
        oldState == null) {
      // 旧状态是蹲下，修改碰撞区域
      removeWhere((component) => component is RectangleHitbox);
      addAll(_customHitBoxes);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (current == PlayerState.jumping) {
      vY += aY * dt;
      sY += vY * dt;
      if (sY > 0) {
        sY = 0;
        current = PlayerState.running;
      }
      y = initY + sY;
    }
  }

  set state(PlayerState newState) {
    PlayerState? old = current;
    if (newState == PlayerState.crashed) {
      current = newState;
      return;
    }
    // 死亡或跳跃中不允许修改状态
    if (old == PlayerState.crashed || old == PlayerState.jumping) return;

    // 蹲下
    if (old == PlayerState.running && newState == PlayerState.down) {
      current = PlayerState.down;
      switchHitBoxByState(current, old);
    }

    // 起立
    if (old != PlayerState.running && newState == PlayerState.running) {
      current = PlayerState.running;
      if (old == PlayerState.down) {
        switchHitBoxByState(current, old);
      }
    }

    // 起跳
    if (old != PlayerState.jumping && newState == PlayerState.jumping) {
      current = PlayerState.jumping;
      vY = -770;
      sY = 0;
      return;
    }
    current = newState;
  }

  @override
  Future<void> onLoad() async {
    _initAnimations();
    switchHitBoxByState(current, null);
  }

  void _initAnimations() {
    animations = {
      PlayerState.running: loadAnimation(
        size: Vector2(88.0, 90.0),
        frames: [Vector2(1514.0, 4.0), Vector2(1602.0, 4.0)],
        stepTime: 0.2,
      ),
      PlayerState.waiting: loadAnimation(
        size: Vector2(88.0, 90.0),
        frames: [Vector2(76.0, 6.0)],
      ),
      PlayerState.jumping: loadAnimation(
        size: Vector2(88.0, 90.0),
        frames: [Vector2(1338.0, 4.0)],
      ),
      PlayerState.crashed: loadAnimation(
        size: Vector2(88.0, 90.0),
        frames: [Vector2(1778.0, 4.0)],
      ),
      PlayerState.down: loadAnimation(
        size: Vector2(114.0, 90.0),
        frames: [Vector2(1866, 6.0), Vector2(1984, 6.0)],
        stepTime: 0.2,
      ),
    };
    current = PlayerState.waiting;
  }

  SpriteAnimation loadAnimation({
    required Vector2 size,
    required List<Vector2> frames,
    double stepTime = double.infinity,
  }) {
    return SpriteAnimation.spriteList(
      frames
          .map((vector) => Sprite(
                game.spriteImage,
                srcSize: size,
                srcPosition: vector,
              ))
          .toList(),
      stepTime: stepTime,
    );
  }

  void restart() {
    x = 0;
    y = initY;
    switchHitBoxByState(current, null);
  }
}
