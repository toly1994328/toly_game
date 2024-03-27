import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:toly_game/bricks/04/config/audio_manager/sound_effect.dart';
import '../heroes/bricks.dart';

import '../bricks_game.dart';
import 'game_top_bar/brick_wall.dart';
import 'playground.dart';
import 'paddle.dart';

class Ball extends SpriteComponent with HasGameRef<BricksGame>, CollisionCallbacks {

  @override
  FutureOr<void> onLoad() {
    sprite = game.loader['Ball_Blue_Shiny-32x32.png'];
    add(CircleHitbox());
    // position = Vector2((kViewPort.width-width)/2, 600);
    return super.onLoad();
  }

  Vector2 v = Vector2(0, 0);

  @override
  void update(double dt) {
    super.update(dt);
    position += v * dt;
  }

  void run() {
    v = Vector2(-350, -350);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Paddle||other is BrickWall) {
      _handleHitPaddle(intersectionPoints.first);
      game.am.play(SoundEffect.ballBrick);
    } else if (other is Brick) {
      _lockCollisionTest(()=> _handleHitBrick(intersectionPoints.first, other));
    } else if (other is Playground) {
      _handleHitPlayground(intersectionPoints.first, other.size);
      game.am.play(SoundEffect.bitWall);

    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _handleHitPlayground(Vector2 position, Vector2 areaSize) {
    if(position.y >= areaSize.y-height){
      game.world.died();
      v = Vector2(0, 0);
      return;
    }

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

  void _lockCollisionTest(VoidCallback callback){
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
    } else if (hitP.y >= brick.height ) {
      // 下部碰撞
      v.y = -v.y;
    } else if (hitP.x >= brick.width) {
      // 右部碰撞
      v.x = -v.x;
    }
    brick.removeFromParent();
    game.am.play(SoundEffect.uiSelect);
  }
}
