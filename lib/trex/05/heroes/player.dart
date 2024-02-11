import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

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
    print("=======onCollisionStart:${intersectionPoints}====================");
    super.onCollisionStart(intersectionPoints, other);
    game.gameOver();
  }

  void toggleDebugMode() {
    debugMode = !debugMode;
  }

  double vY = 0; // 竖直速度
  double aY = 9.8 * 200; // 竖直加速度
  double sY = 0; // 竖直位移

  void jump() {
    if (current == PlayerState.jumping) {
      return;
    }
    vY = -720;
    sY = 0;
    current = PlayerState.jumping;
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

  void toggleState() {
    int nextIndex = (current?.index ?? 0) + 1;
    nextIndex = nextIndex % PlayerState.values.length;
    current = PlayerState.values[nextIndex];
  }

  void down() {
    if(current==PlayerState.running){
      current = PlayerState.down;
    }
  }
  void running() {
    if(current!=PlayerState.jumping){
      current = PlayerState.running;
    }
  }

  @override
  Future<void> onLoad() async {
    _initAnimations();
    add(
      RectangleHitbox.relative(
        Vector2(0.7, 0.6),
        position: Vector2(0, height / 3),
        parentSize: size,
      )..debugMode=true,
    );
    // Head hitbox
    add(
      RectangleHitbox.relative(
        Vector2(0.45, 0.35),
        position: Vector2(width / 2, 0),
        parentSize: size,
      )..debugMode=true,
    );
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
    current = PlayerState.running;
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
}