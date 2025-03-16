import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

import '../config/audio_manager/sound_effect.dart';
import '../heroes/bricks.dart';

import '../bricks_game.dart';
import 'died_line.dart';
import 'game_top_bar/brick_wall.dart';
import 'playground.dart';
import 'paddle.dart';

class Ball extends SpriteComponent
    with HasGameRef<BricksGame>, CollisionCallbacks {
  @override
  FutureOr<void> onLoad() {
    priority = 6;
    sprite = game.loader['Ball_Blue_Shiny-32x32.png'];
    add(CircleHitbox());
    // position = Vector2((kViewPort.width-width)/2, 600);
    return super.onLoad();
  }

  Vector2 v = Vector2(0, 0);

  double _timeRecord = 0;

  @override
  void update(double dt) {
    super.update(dt);
    _timeRecord += dt;
    if (game.status == GameStatus.playing && _timeRecord > 0.06) {
      showPathParticle();
      _timeRecord = 0;
    }
    position += v * dt;
  }

  void run() {
    v = Vector2(-350, -350);
  }

  @override
  void onRemove() {
    if (game.status != GameStatus.playing) return;
    showDieParticle(position);
    Future.delayed(const Duration(milliseconds: 800)).then((value) {
      bool noBall = game.world.children.whereType<Ball>().isEmpty;
      if (noBall) {
        game.world.died();
      }
    });
    super.onRemove();
  }

  void showDieParticle(Vector2 position) {
    final List<Sprite> spriteList = [];
    for (int i = 1; i <= 12; i++) {
      String name = 'died_${i.toString().padLeft(4, '0')}.png';
      spriteList.add(game.loader[name]);
    }
    SpriteAnimation sa = SpriteAnimation.spriteList(spriteList, stepTime: 0.1, loop: false);
    game.world.add(
      ParticleSystemComponent(
          position: position - Vector2(0, 80),
          particle: SpriteAnimationParticle(
            lifespan: spriteList.length * 0.05,
            animation: sa,
          )),
    );
  }

  void showPathParticle() {
    CircleParticle circleParticle = CircleParticle(
      radius: 4,
      lifespan: 1,
      paint: Paint()..color = Colors.white.withOpacity(0.2),
    );

    final ParticleSystemComponent psc = ParticleSystemComponent(
      position: position - Vector2(0, size.y / 2),
      particle: circleParticle,
    );
    game.world.add(psc);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is DiedLine) {}

    if (other is Paddle || other is BrickWall) {
      _handleHitPaddle(intersectionPoints.first);
      game.am.play(SoundEffect.ballBrick);
    } else if (other is Brick) {
      if (game.world.isInvincible) {
        game.world.onBrickWillRemove(other);
        return;
      }
      _lockCollisionTest(
          () => _handleHitBrick(intersectionPoints.first, other));
    } else if (other is Playground) {
      _handleHitPlayground(intersectionPoints.first, other.size);
      game.am.play(SoundEffect.bitWall);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _handleHitPlayground(Vector2 position, Vector2 areaSize) {
    // 四周拐角
    if (position.x < height && position.y < height ||
        position.x < height && position.y > areaSize.y - height ||
        position.x > areaSize.x - height && position.y > areaSize.y - height ||
        position.x > areaSize.x - height && position.y < height) {
      v.y = -v.y;
      v.x = -v.x;
      return;
    }
    if (position.y <= 0) {
      v.y = -v.y; // 上壁
    } else if (position.x <= 0) {
      v.x = -v.x; // 左壁
    } else if (position.x >= areaSize.x) {
      v.x = -v.x; // 右壁
    }
  }

  void _handleHitPaddle(Vector2 position) {
    v.y = -v.y;
  }

  // 锁定砖块碰撞检测
  bool _lockedHitBrick = false;

  void _lockCollisionTest(VoidCallback callback) {
    if (_lockedHitBrick) return;
    _lockedHitBrick = true;
    callback();
    scheduleMicrotask(() => _lockedHitBrick = false);
  }

  void _handleHitBrick(Vector2 hitPos, Brick brick) {
    Vector2 hitP = hitPos - brick.position;

    if (hitP.y <= 0) {
      // 顶部碰撞
      v.y = -v.y;
    } else if (hitP.x <= 0) {
      // 左部碰撞
      v.x = -v.x;
    } else if (hitP.y >= brick.height) {
      // 下部碰撞
      v.y = -v.y;
    } else if (hitP.x >= brick.width) {
      // 右部碰撞
      v.x = -v.x;
    }
    game.world.onBrickWillRemove(brick);
  }
}
